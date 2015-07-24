@QuestionDisplay = React.createClass(
  # This method is not called for the initial render
  componentWillReceiveProps: (nextProps) ->
    console.log("______componentWillReceiveProps______")
    this.setState
        question: nextProps.question
  
  getDefaultProp: ->
    question: this.props.question

  getInitialState: ->
    question: this.props.question
  render: ->
      if this.state.question?
        <div className="list-group-item">
          <h1><span id="countdown-container"></span> { this.state.question.title }</h1>
          <hr />
          <ul>
            {
                this.state.question.answers.map( ( answer )->
                    <AnswerLine key={answer.id} answer={answer} />
                )
            }
          </ul>
        </div>
      else
        <p>Sorry no question for now</p>
    
)
