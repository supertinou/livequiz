@ParticipantsList = React.createClass(
  #This method is not called for the initial render.
  componentWillReceiveProps: (nextProps) ->
    current_participants = this.state.participants
    updated_participants = current_participants

    addOrUpdateParticipant =(new_participant) ->
      existing_participant_index = _.findIndex(current_participants, (current_participant) ->
          current_participant.uuid is new_participant.uuid
      )
      if existing_participant_index?
        new_name = if new_participant.name? then new_participant.name else current_participants[existing_participant_index].name 
        new_participant = {uuid: new_participant.uuid, name: new_name, status: new_participant.status }
        current_participants[existing_participant_index] = new_participant
      else
        updated_participants.push(new_participant)

    if nextProps.onlineParticipants?
        _.each(nextProps.onlineParticipants, (participant) ->
            addOrUpdateParticipant(participant)
        )
    else if nextProps.newParticipant?
      addOrUpdateParticipant(nextProps.newParticipant)

    this.setState
        participants: updated_participants
  
  getDefaultProp: ->
    participants: this.props.participants

  getInitialState: ->
    participants: ( this.props.participants || this.props.onlineParticipants )
  render: ->
      <div className="panel panel-default">
          <div className="panel-heading c-list">
                    <span className="title">Participants ({countOnlineParticipants(this.state.participants)} online)</span>
                    <ul className="pull-right c-controls">
                        <li><a href="#" data-toggle="tooltip" data-placement="top" title="Invite someone"><i className="fa fa-plus"></i></a></li>
                    </ul>
          </div>

          <ul className="list-group" id="contact-list">
            {
                this.state.participants.map( (participant)->
                    <ParticipantStatus key={participant.uuid} participant={participant} />
                )
            }
          </ul>
      </div>
    
)
