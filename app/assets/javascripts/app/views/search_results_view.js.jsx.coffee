###* @jsx React.DOM ###

@SearchResultsView = React.createClass

  render: ->
    results = this.props.results.map (result) ->
      `(
        <div className="panel panel-default">
          <div className="panel-heading">
            <a href={'http://github.com/' + result.name}>{result.name}</a>
          </div>
          <div className="panel-body">{result.description}</div>
        </div>
      )`
    `(
      <div className="d10-push-ends">
        {results}
      </div>
    )`