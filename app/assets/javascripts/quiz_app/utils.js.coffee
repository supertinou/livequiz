@countOnlineParticipants = (participants) ->
    _.where(participants, {status: "online"}).length 

@gravatarUrl = (email, size) ->
    size ||= 200
    'http://www.gravatar.com/avatar/' + md5(email) + "?d=retro&s=#{size}"