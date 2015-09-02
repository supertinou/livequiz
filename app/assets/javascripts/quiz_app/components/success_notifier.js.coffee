@SuccessNotifier = React.createClass
  render: ->
      [image, text] = if this.props.success 
                          ['images/correct.png','Well done !']
                      else
                          ['images/wrong.png', 'Wrong answer !']

      <div className="list-group-item">
        <div className="row">
          <div className="col-md-2">
            <img className='media-object' src={image} />
          </div>
          <div className="col-md-9">
            <h1>{text}</h1>
          </div>
        </div>
      </div>