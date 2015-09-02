@AnswerLine = React.createClass
  sendAnswer: ->
      liveQuiz.answerQuestion(this.props.answer.id)

  render: ->
  	  <div>
      	<button type="button" onClick={this.sendAnswer} className="btn btn-default btn-lgt btn-block">{this.props.answer.title}</button>
      	<br />
      </div>