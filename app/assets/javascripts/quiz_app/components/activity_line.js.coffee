@ActivityLine = React.createClass
  render: ->
      activity = this.props.activity
      [action_verb, action_icon] = switch(activity.action)
                  when 'join' then ['has joined the quiz', 'fa fa-sign-in online']
                  when 'timeout' then ['has left the quiz', 'fa fa-sign-out offline']
                  when 'leave' then ['has left the quiz', 'fa fa-sign-out offline']
                  when 'state-change' then ["has changed is name to #{activity.data.name}", 'fa fa-exchange']
                  when 'answered' 
                    if activity.data.correct
                      ['has answered the question correctly', 'fa fa-check-circle online']
                    else
                      ['has answered the question wrongly', 'fa fa-check-circle offline']
                      
      <article className="panel panel-danger panel-outline">
          <div className="panel-heading icon">
              <i className={action_icon}></i>
          </div>
          <div className="panel-body">
              <strong>{activity.data.name}</strong> {action_verb} <span title={moment.unix(activity.timestamp).format('llll')} data-livestamp={activity.timestamp}></span>
          </div>
      </article>