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

    @handlers = search: searchHandler

  componentDidMount: ->
    $('.js-waypoint').waypoint (direction) =>
      if direction is 'down'
        if @state.searchResults.length is (parseInt(@state.page) + 1) * 50
          @props.actions.nextPageAction.onNext
            page: parseInt(@state.page) + 1
            query: @refs.query.getDOMNode().value
    , offset: 'bottom-in-view'

  componentDidUpdate: ->
    $.waypoints 'refresh'

  render: ->
    `(
      <div className="user-search d10-push-top">
        <input placeholder="Search for your starred repos" ref="query" type="text" onChange={this.handlers.search}/>
        <SearchResultsView results={this.state.searchResults} />
      </div>
    )`