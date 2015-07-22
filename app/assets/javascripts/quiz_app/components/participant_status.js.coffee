@ParticipantStatus = React.createClass(
  render: ->
      classes = classNames('fa', 'fa-circle', this.props.participant.status)
      <li className='participant-status'><i className={ classes }></i> {this.props.participant.name}
      </li>
    
)