class Repository
  include Mongoid::Document

  store_in collection: "repos"
  field :name, type: String
  field :indexed, type: Boolean
  field :stargazers, type: Integer
  field :forks, type: Integer
  field :description, type: String
  field :searchfield, type: String

  index({searchfield: "text"})
  index({ name: 1 }, { unique: true, background: true })

end