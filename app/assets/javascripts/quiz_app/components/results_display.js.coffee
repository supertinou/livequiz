@ResultsDisplay = React.createClass(  
  render: ->
      <div className="list-group-item">
          <h1>The quiz session is finished</h1>
          <h3>Here are the results:</h3>
          <br />
          <table className='table-striped table-bordered'>
            <tr>
                <th>Name</th>
                <th>Points</th>
                <th>Correct answers</th>
                <th>Wrong answers</th>
            </tr>
            {
                this.props.results.map( ( result )->
                    <tr key={result.uuid} >
                      <td>{result.name}</td>
                      <td><h4>{result.points}</h4></td>
                      <td><h4>{result.correct_answers_number}</h4></td>
                      <td><h4>{result.wrong_answers_number}</h4></td>
                    </tr>
                )
            }
          </table>
        </div>
)
