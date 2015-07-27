class QuizSessionsController < QuizApplicationController

	def show	
		@participant = Participant.find_by(authorization_key: params[:authorization_key], authorization_password: params[:authorization_password] )
		@session = Session.find_by(access_key: params[:session_key])
		
		if @participant.nil? || (@session.id != @participant.session )
			redirect_to root_path, notice: 'You are not authorized to access this sessions' if @participant.nil?
		end

		@participant_list = @session.participants.to_a.collect do  |participant|
			status = @participant.id == participant.id ? 'online' : ''
			{ uuid: participant.authorization_key, status: status , name: participant.name, email: participant.email  }
		end
	end
end