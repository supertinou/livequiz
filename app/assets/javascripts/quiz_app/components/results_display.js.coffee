@ResultsDisplay = React.createClass(  
  render: ->
      <div className="list-group-item">
          <div className="row">
            <div className="col-md-2">
              <img className='media-object' src="/assets/graduated.png" />
            </div>
            <div className="col-md-9">
              <h1>The quiz session is finished</h1>
              <h3>Here are the results:</h3>
            </div>
          </div>
          <table className='table-striped table-bordered'>
            <tr> 
                <th className='text-center'></th>
                <th className='text-center'>Name</th>
                <th className='text-center'>Points</th>
                <th className='text-center'>Correct answers</th>
                <th className='text-center'>Wrong answers</th>
            </tr>
            {
                this.props.results.map( ( result )->
                    <tr key={result.uuid} >
                      <td className='text-center'><img src={gravatarUrl(result.email, 50)} alt="{result.email}" className="img-responsive img-circle" /></td>
                      <td className='text-center'>{result.name}</td>
                      <td className='text-center'><h4>{result.points}</h4></td>
                      <td className='text-center'><h4>{result.correct_answers_number}</h4></td>
                      <td className='text-center'><h4>{result.wrong_answers_number}</h4></td>
                    </tr>
                )
            }
          </table>
      </div>
)
