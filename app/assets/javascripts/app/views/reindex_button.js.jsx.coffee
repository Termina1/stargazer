###* @jsx React.DOM ###

@ReindexButton = React.createClass

  reindex: (event) ->
    return if $('.js-reindex-btn').attr('disabled')
    $.post "/users/#{USER_ID}/reindex", (result) ->
      if result.ok
        $('.js-error').text('')
        $('.js-reindex-btn').removeClass('btn-primary')
          .addClass('btn-success')
          .attr disabled: "disabled"
      else
        $('.js-error').text(result.error)

  render: ->
    `(
      <div>
        <button className="btn btn-primary reindex-btn js-reindex-btn" onClick={this.reindex}>Reindex</button>
        <code><span className="js-error error"></span></code>
      </div>
    )`