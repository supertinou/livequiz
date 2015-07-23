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
      <div className="list-group-item">
          <h4 className="list-group-item-heading">Online ({countOnlineParticipants(this.state.participants)})</h4>
          <hr />
            <ul>
              {
                  this.state.participants.map( (participant)->
                      <ParticipantStatus key={participant.uuid} participant={participant} />
                  )
              }
            </ul>
      </div>
    
)
