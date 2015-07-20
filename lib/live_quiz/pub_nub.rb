require "pubnub"

module LiveQuiz
	module PubNub
		extend self
		def client
			Pubnub.new(
		      publish_key: ENV['PUBNUB_PUBLISH_KEY'],
		      subscribe_key: ENV['PUBNUB_SUBSCRIBE_KEY'],
		      secret_key: ENV['PUBNUB_SECRET_KEY'],
		      connect_callback: lambda { |msg| Rails.logger.debug "CONNECTED: #{msg.inspect}" },
		      error_callback: lambda { |msg| raise "Error connecting to PubNub: #{msg.inspect}" },
		      logger: Rails.logger
		    )
		end
	end
end