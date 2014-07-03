#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Stargazer =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}

$(document).ready ->

  if $('.js-user-search').length
    view = new Stargazer.Views.SearchView
    reindex = new Stargazer.Views.ReindexButton
    React.renderComponent view, $('.js-user-search')[0]
    React.renderComponent reindex, $('.js-reindex')[0]