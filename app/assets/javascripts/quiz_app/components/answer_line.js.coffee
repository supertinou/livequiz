@AnswerLine = React.createClass(
  sendAnswer: ->
      console.log("____sendAnswer____")
      liveQuiz.answerQuestion(this.props.answer.id)

  render: ->
      <button type="button" onClick={this.sendAnswer} className="btn btn-default btn-lgt btn-block">{this.props.answer.title}</button>
      
)