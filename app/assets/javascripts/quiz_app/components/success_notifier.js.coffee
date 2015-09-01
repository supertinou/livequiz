@SuccessNotifier = React.createClass( 
  render: ->
      image = if this.props.success then "correct.png" else "wrong.png"
      text = if this.props.success then "Well done !" else "Wrong answer !"
      <div className="list-group-item">
        <div className="row">
          <div className="col-md-2">
            <img className='media-object' src="/images/{image}}" />
          </div>
          <div className="col-md-9">
            <h1>{text}</h1>
          </div>
        </div>
      </div>
)