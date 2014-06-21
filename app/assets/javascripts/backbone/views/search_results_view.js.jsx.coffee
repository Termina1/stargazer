###* @jsx React.DOM ###

Stargazer.Views.SearchResults = React.createBackboneClass

  render: ->
    results = this.props.results.map (result) ->
      `(
        <li>
          <a href={'http://github.com/' + result.get('name')}>{result.get('name')}</a>
          <p>{result.get('description')}</p>
        </li>
      )`
    `(
      <ul className="d10-push-bottom">
        {results}
      </ul>
    )`