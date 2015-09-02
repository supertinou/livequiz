@ActivityFeed = React.createClass

  componentWillReceiveProps: (nextProps) ->
    
    new_activity = nextProps.newActivity
    updated_activities = this.state.activities
    updated_activities.unshift(new_activity) if new_activity.data?

    this.setState
        activities: updated_activities

  getInitialState: ->
    activities: [] 

  activityList: ->
    <div className="timeline">
      <div className="line text-muted"></div>
        {
            this.state.activities.map (activity )->
                key = activity.timestamp+'-'+activity.uuid
                <ActivityLine key={key} activity={activity} />
        }
      </div>     

  noActivity: ->
    <div className='well well-sm'>
      <div className="row">
        <div className="col-md-4">
          <img className='media-object' src="/images/no-activity.png" />
        </div>
        <div className="col-md-8">
          <h4>No activity since your last logon</h4>
        </div>
      </div>
    </div>

  render: ->
      if this.state.activities.length > 0
        @activityList()
      else 
        @noActivity()
