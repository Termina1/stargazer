class StarService

  def self.importFor(userId)
    user = User.where(id: userId).first
    github = Github.new oauth_token: user.token
    page = 1
    per_page = 100
    allrepos = []
    loop do
      repos = github.activity.starring.starred per_page: per_page, page: page
      page = page + 1
      allrepos += repos.map{ |el| el.full_name }
      puts repos.count
      break if repos.count == 0
    end
    user.repos = allrepos
    user.indexed = Time.now
    user.save
    allrepos.each do |el|
      msg = el + "/" + user.token
      Redis.current.publish Rails.application.secrets.redis_channel, msg
    end
  end

  def self.get_indexed_stars
    users = User.all.map{ |el| { id: el.id.to_s, name: el.username, repos: el.repos } }
    users.each do |user|
      user[:indexed] = Repository.in(name: user[:repos]).count()
      user[:repos] = user[:repos].count
    end
    users
  end

  def self.get_indexed_stars_by_user(name)
    user = User.where(username: name).first
    starred = user.repos
    indexed = Repository.in(name: user[:repos]).map{ |el| el.name }
    not_indexed = starred - indexed
    {user: name, starred: starred, indexed: indexed, not_indexed: not_indexed}
  end

end