Rails.configuration.middleware.use RailsWarden::Manager do |manager|
  manager.default_strategies :github_strategy
  manager.failure_app = LoginController
end

# Setup Session Serialization
class Warden::SessionSerializer
  def serialize(record)
    record.id
  end

  def deserialize(id)
    User.where(id: id["$oid"].to_s).first
  end
end

Warden::Strategies.add(:github_strategy) do
  def authenticate!
    u = User.by_github_or_create(request.env['omniauth.auth'])
    u.nil? ? fail!("Could not log in") : success!(u)
  end
end