module ApplicationHelper
	def quiz_session_path(participant)
		path = "/quiz_sessions/#{participant.session.access_key}/#{participant.authorization_key}/#{participant.authorization_password}"
		"http://"+ ENV['HOST']+path
	end
end
