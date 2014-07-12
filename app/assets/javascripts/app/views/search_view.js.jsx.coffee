###* @jsx React.DOM ###

#= require ./search_results_view

@SearchView = React.createClass
  getInitialState: -> searchResults: []

  componentWillMount: ->
    searchHandler = EventHandler.create()
    searchHandler
      .map((event) ->event.target.value)
      .subscribe @props.actions.searchAction
    @props.store.results.subscribe @setState.bind(this)

    @handlers =
      search: searchHandler

  render: ->
    `(
      <div className="user-search d10-push-top">
        <input placeholder="Search for your starred repos" type="text" onChange={this.handlers.search}/>
        <SearchResultsView results={this.state.searchResults} />
      </div>
    )`