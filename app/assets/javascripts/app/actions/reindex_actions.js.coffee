class @ReindexActions
  constructor: (updates) ->
    @reindexAction = new Rx.Subject()

    @reindexAction
      .flatMap(->
        $.post "/users/#{USER_ID}/reindex"
      ).map((result) ->
        if result.ok
          error: "", disabled: true, done: true
        else
          error: result.error, disabled: false, done: true
      ).subscribe updates

