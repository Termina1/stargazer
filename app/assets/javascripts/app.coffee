#= require ./app/stores/search_store
#= require ./app/actions/search_actions
#= require ./app/actions/reindex_actions
#= require ./app/views/search_view
#= require ./app/views/reindex_button

$(document).ready ->
  if $('.js-user-search').length

    store = new SearchStore
    actions = new SearchActions store.updates
    reindex = new ReindexActions store.reindexes

    view = new SearchView actions: actions, store: store
    reindex = new ReindexButton actions: reindex, store: store
    React.renderComponent view, $('.js-user-search')[0]
    React.renderComponent reindex, $('.js-reindex')[0]