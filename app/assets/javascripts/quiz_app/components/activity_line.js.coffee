@ActivityLine = React.createClass(
  render: ->
      activity = this.props.activity
      action_verb = switch(activity.action)
                  when 'join' then 'has joined the quiz'
                  when 'timeout' then 'has left'
                  when 'leave' then 'has left the quiz'
                  when 'state-change' then "has changed is name to #{activity.data.name}"
                  when 'answered' 
                    if activity.data.correct
                      "has answered the question correctly"
                    else
                      "has answered the question wrongly"

      action_icon = switch(activity.action)
                  when 'join' then 'fa-sign-in online'
                  when 'timeout' then 'fa-sign-out offline'
                  when 'leave' then 'fa-sign-out offline'
                  when 'state-change' then 'fa-exchange'
                  when 'answered' 
                    if activity.data.correct
                      'fa-check-circle online'
                    else
                      'fa-check-circle offline'


      classes = classNames('fa', action_icon)
      name = if activity.data? then activity.data.name else getParticipantNameFromUuid(activity.uuid)
      <article className="panel panel-danger panel-outline">
    
            <div className="panel-heading icon">
                <i className={ classes }></i>
            </div>

            <div className="panel-body">
                <strong>{name}</strong> {action_verb} <span title={moment.unix(activity.timestamp).format('llll')} data-livestamp={activity.timestamp}></span>
            </div>
  
    
        </article>
    
)