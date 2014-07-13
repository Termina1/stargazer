###* @jsx React.DOM ###

@ReindexButton = React.createClass

  getInitialState: -> error: "", disabled: false, done: false

  componentWillMount: ->
    reindexHandler = EventHandler.create()
    reindexHandler
      .filter(=> not @state.disabled)
      .subscribe @props.actions.reindexAction

    @props.store.reindexes.subscribe @setState.bind(this)

    @handlers = reindex: reindexHandler

  render: ->
    if @state.done and not @state.error
      cls = 'btn-success'
    else
      cls = 'btn-primary'
    disabled = if @state.disabled then "disabled" else ""
    `(
      <div>
        <button className={"btn reindex-btn " + cls} disabled={disabled} onClick={this.handlers.reindex}>Reindex</button>
        <code><span className="js-error error">{this.state.error}</span></code>
      </div>
    )`