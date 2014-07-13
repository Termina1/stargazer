class @SearchStore
  constructor: ->
    @updates = new Rx.BehaviorSubject(searchResults: [], page: 0)

    @reindexes = new Rx.Subject()

    @results = @updates.scan((results, action) -> action results)

    @results.subscribe()