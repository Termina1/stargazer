###* @jsx React.DOM ###

Stargazer.Views.SearchResults = React.createBackboneClass

  render: ->
    results = this.props.results.map (result) ->
      `(
        <div className="panel panel-default">
          <div className="panel-heading">
            <a href={'http://github.com/' + result.get('name')}>{result.get('name')}</a>
          </div>
          <div className="panel-body">{result.get('description')}</div>
        </div>
      )`
    `(
      <div className="d10-push-ends">
        {results}
      </div>
    )`