class Stargazer.Models.SearchCollection extends Backbone.Collection
  url: -> "/users/#{USER_ID}/search"
  model: Stargazer.Models.Repository
