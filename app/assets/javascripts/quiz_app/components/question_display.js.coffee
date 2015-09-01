@QuestionDisplay = React.createClass(
  renderQuestion:  ->
    <div>
      <div className="list-group-item">
        <div className="row">
          <div className="col-md-2">
            <img className='media-object' src="/images/question.png" />
          </div>
          <div className="col-md-9">
            <h1>{ this.props.question.title }</h1>
          </div>
        </div>
      </div>
      <br />
      <br />
      <div className="list-group-item">
      <br />
        <ul>
          {
              this.props.question.answers.map( ( answer )->
                  <AnswerLine key={answer.id} answer={answer} />
              )
          }
        </ul>
      </div>
    </div>
  renderWaitingScreen: ->
    <div className="list-group-item">
            <div className="row">
              <div className="col-md-3">
                <img className='media-object' src="/images/cafe.png" />
              </div>
              <div className="col-md-8">
                  <br />
                  <h2 className="media-heading">Quiz not yet started</h2>
                  <h4 className='text-muted'>Take your time to get a coffee <i className="fa fa-circle-o-notch fa-spin"></i></h4>
              </div>
            </div>
        </div>

  render: ->
    if this.props.question?
      @renderQuestion()  
    else 
      @renderWaitingScreen()
        
)