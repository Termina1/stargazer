class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :username, type: String
  field :github_id, type: Integer
  field :token, type: String
  field :repos, type: Array
  field :indexed, type: Time

  def self.by_github_or_create(data)
    u = User.where(github_id: data.uid).first
    if u.nil?
      u = User.create(
        username: data.info.nickname,
        github_id: data.uid,
        token: data.credentials.token
      )
    end
    u
  end
end