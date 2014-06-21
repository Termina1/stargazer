class StarService

  def self.importFor(user)
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
    user.save
    allrepos.each{ |el| Redis.current.publish "starray", el }
  end

end