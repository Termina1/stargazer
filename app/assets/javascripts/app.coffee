#= require ./app/stores/search_store
#= require ./app/actions/search_actions
#= require ./app/views/search_view
#= require ./app/views/reindex_button

$(document).ready ->
  if $('.js-user-search').length

    store = new SearchStore
    actions = new SearchActions(store.updates)

    view = new SearchView actions: actions, store: store
    reindex = new ReindexButton
    React.renderComponent view, $('.js-user-search')[0]
    React.renderComponent reindex, $('.js-reindex')[0]