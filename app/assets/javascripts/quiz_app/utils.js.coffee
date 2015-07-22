 @countOnlineParticipants = (participants) ->
 	_.where(participants, {status: "online"}).length 

