###* @jsx React.DOM ###

Stargazer.Views.SearchView = React.createBackboneClass
  getInitialState: ->
    searchResults: []
    collection: new Stargazer.Models.SearchCollection()

  render: ->
    wrapedSearch = =>
      _.throttle(this.loadSearch, 1000).apply(@, arguments)
    SearchResults = Stargazer.Views.SearchResults
    `(
      <div className="user-search d10-push-top">
        <input placeholder="Search for your starred repos" type="text" onChange={wrapedSearch}/>
        <SearchResults results={this.state.searchResults} />
      </div>
    )`

  loadSearch: (event)->
    return if 0 < event.target.value.length < 3
    this.state.collection.fetch
      data: { query: event.target.value }
      reset: true
      success: =>
        this.setState
          collection: this.state.collection
          searchResults: this.state.collection.models