class @SearchStore
  constructor: ->
    @updates = new Rx.BehaviorSubject(searchResults: [], page: 0)

    @results = @updates
      .filter((results) -> results?.searchResults)
      .scan((results, action) -> action results)

    @results.subscribe()