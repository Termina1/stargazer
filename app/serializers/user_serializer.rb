class UserSerializer < ActiveModel::Serializer
  attributes :id, :description, :name, :stargazers, :forks

  def id
    object._id.to_s
  end
end