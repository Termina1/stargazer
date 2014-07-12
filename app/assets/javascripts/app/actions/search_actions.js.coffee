class @SearchActions
  constructor: (updates) ->
    @searchAction = new Rx.Subject()
    @searchAction
      .filter((query) ->
        query.length > 2
      ).throttle(100)
      .flatMap((query) -> $.get("/users/#{USER_ID}/search", query: query).promise())
      .map((results) -> (stored) -> results)
      .subscribe updates