class @SearchActions
  constructor: (updates) ->
    @searchAction = new Rx.Subject()
    @nextPageAction = new Rx.Subject()

    @searchTermChain = @searchAction
      .filter(@filterLength)
      .throttle(100)

    @searchTermChain
      .map((query) => page: 0, query: query)
      .flatMap(@searchRequest)
      .map(@replaceResults)
      .subscribe updates

    @nextPageAction
      .combineLatest(@searchTermChain, (page, query) ->
        page: page, query: query
      )
      .filter(@filterLengthObject)
      .flatMap(@searchRequest)
      .map(@concatResults)
      .subscribe updates

  filterLength: (query) => query.length > 2

  filterLengthObject: (options) => options.query.length > 2

  searchRequest: (options) =>
    $.get("/users/#{USER_ID}/search", query: options.query, page: options.page)
      .promise()

  replaceResults: (results) => (stored) -> results

  concatResults: (results) => (stored) -> stored.concat results