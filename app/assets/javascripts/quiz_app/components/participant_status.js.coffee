@ParticipantStatus = React.createClass(
  render: ->
      status_classes = classNames('c-info', 'fa', 'fa-circle', this.props.participant.status)
      email = this.props.participant.email
      email ||= 'random@provider.com'

      <li className="list-group-item">
        <div className="col-xs-12 col-sm-4">
            <img src={gravatarUrl(email, 200)} alt="{this.props.participant.name}" className="img-responsive img-circle" />
        </div>
        <div className="col-xs-12 col-sm-7">
            <span className="name">{this.props.participant.name}</span><br/>
            <span className={ status_classes } data-toggle="tooltip" title={this.props.participant.status}></span>
            <span className="visible-xs"> <br/></span>
            
            <span className="fa fa-envelope-o c-info" data-toggle="tooltip" title={this.props.participant.email}></span>
            <span className="visible-xs"><br/></span>
        </div>
        <div className="clearfix"></div>
      </li>    
    
)