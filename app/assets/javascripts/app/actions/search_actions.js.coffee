class @SearchActions
  constructor: (updates) ->
    @searchAction = new Rx.Subject()
    @nextPageAction = new Rx.Subject()

    @searchAction
      .filter(@filterLength)
      .throttle(100)
      .map((query) => page: 0, query: query)
      .flatMap(@searchRequest)
      .map(@noMeta)
      .map(@replaceResults)
      .subscribe updates

    @nextPageAction
      .filter(@filterLengthObject)
      .flatMap(@searchRequest)
      .map(@noMeta)
      .map(@concatResults)
      .subscribe updates

  filterLength: (query) => query.length > 2

  filterLengthObject: (options) => options.query.length > 2

  searchRequest: (options) =>
    $.get("/users/#{USER_ID}/search", query: options.query, page: options.page)
      .promise()

  replaceResults: (results) => (stored) ->
    page: results.page
    searchResults: results.searchResults

  concatResults: (results) => (stored) ->
    page: results.page
    searchResults: stored.searchResults.concat results.searchResults

  noMeta: (result) ->
    searchResults: result.searchResults,
    page: result.meta.page