class @SearchStore
  constructor: ->
    @updates = new Rx.BehaviorSubject(searchResults: [])

    @results = @updates.scan((results, action) ->
      searchResults: action results.searchResults
    )

    @results.subscribe()