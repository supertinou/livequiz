@ActivityFeed = React.createClass(
  #This method is not called for the initial render.
  componentWillReceiveProps: (nextProps) ->
    
    new_activity = nextProps.newActivity
    updated_activities = this.state.activities
    # Only add activity who has owner name
    updated_activities.unshift(new_activity) if new_activity.data?

    this.setState
        activities: updated_activities
  
  getDefaultProp: ->
    activities: this.props.activities

  activityList: ->
      <ul>
          {
              this.state.activities.map( (activity )->
                  key = activity.timestamp+'-'+activity.uuid
                  <ActivityLine key={key} activity={activity} />
              )
          }
        </ul>

  noActivity: ->
      <div>
          <br />
          <p>No activity</p>
          <br />
      </div>

  getInitialState: ->
    activities: [] 
  render: ->
      if this.state.activities.length > 0
        @activityList()
      else 
        @noActivity()
    
)
