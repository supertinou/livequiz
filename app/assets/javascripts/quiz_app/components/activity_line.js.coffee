@ActivityLine = React.createClass(
  render: ->
      activity = this.props.activity
      action_verb = switch(activity.action)
      		when 'join' then 'has joined the quiz'
      		when 'timeout' then 'has been disconnected'
      		when 'leave' then 'has leaved the quiz'
      		when 'state-change' then "has changed is name to #{activity.data.name}"

      action_icon = switch(activity.action)
      		when 'join' then 'fa-sign-in online'
      		when 'timeout' then 'fa-sign-out offline'
      		when 'leave' then 'fa-sign-out offline'
      		when 'state-change' then 'fa-exchange'

      classes = classNames('fa', action_icon)
      name = if activity.data? then activity.data.name else getParticipantNameFromUuid(activity.uuid)
      <li className='small'>
      		<i className={ classes }></i> <b>{name}</b> {action_verb} <span title={moment.unix(activity.timestamp).format('llll')} data-livestamp={activity.timestamp}></span>
      </li>
    
)