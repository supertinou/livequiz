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

      <div className="timeline">
    
        <div className="line text-muted"></div>

          {
              this.state.activities.map( (activity )->
                  key = activity.timestamp+'-'+activity.uuid
                  <ActivityLine key={key} activity={activity} />
              )
          }
    
        </div>
       

  noActivity: ->
      <div>
         
      </div>

  getInitialState: ->
    activities: [] 
  render: ->
      <div>
        <div className="panel panel-default">
            <div className="panel-heading c-list">
                      <span className="title">Activity Feed</span>
            </div>
        </div>

        { 
          if this.state.activities.length > 0
            @activityList()
          else 
            @noActivity()
        }
      </div>
    
)
