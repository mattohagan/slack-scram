Slack = require './node-slack-client/index.coffee'

token = 'xoxb-4498315086-SMWYoZm0kfSTLc5CUfcRuRd9'
autoReconnect = true
autoMark = true

slack = new Slack(token, autoReconnect, autoMark)

slack.on 'open', ->
  channels = []
  groups = []
  unreads = slack.getUnreadCount()

  # Get all the channels that bot is a member of
  channels = ("##{channel.name}" for id, channel of slack.channels when channel.is_member)

  # Get all groups that are open and not archived
  groups = (group.name for id, group of slack.groups when group.is_open and not group.is_archived)

  console.log "Welcome to Slack. You are @#{slack.self.name} of #{slack.team.name}"
  console.log 'You are in: ' + channels.join(', ')
  console.log 'As well as: ' + groups.join(', ')

  messages = if unreads is 1 then 'message' else 'messages'

  console.log "You have #{unreads} unread #{messages}"

slack.on 'message', (message) ->
  channel = slack.getChannelGroupOrDMByID(message.channel)
  user = slack.getUserByID('message.user')
  #user = '@fitz'
  response = ''

  {type, ts, text} = message

  channelName = if channel?.is_channel then '#' else ''
  channelName = channelName + if channel then channel.name else 'UNKNOWN_CHANNEL'

  userName = if user?.name? then "@#{user.name}" else "UNKNOWN_USER"

  console.log """
    Received: #{type} #{channelName} #{userName} #{ts} "#{text}"
  """


  # Respond to messages with the reverse of the text received.
  if type is 'message' and text? and channel?
    #response = text.split('').join('')
    #channel.send response
      response = text.split('').join('')

      if response == 'New Game'
        channel.send "Welcome to Scram!"
    console.log """
      @#{slack.self.name} responded with "#{response}"
    """
  else
    #this one should probably be impossible, since we're in slack.on 'message'
    typeError = if type isnt 'message' then "unexpected type #{type}." else null
    #Can happen on delete/edit/a few other events
    textError = if not text? then 'text was undefined.' else null
    #In theory some events could happen with no channel
    channelError = if not channel? then 'channel was undefined.' else null

    #Space delimited string of my errors
    errors = [typeError, textError, channelError].filter((element) -> element isnt null).join ' '

    console.log """
      @#{slack.self.name} could not respond. #{errors}
    """


slack.on 'error', (error) ->
  console.error "Error: #{error}"


slack.login()


description =
  five9: 'You awake in a room and see an open door in front of you. (Go North, East, South, or West) :'
  five8: 'You step outside and see a huge ass dragon fly by. He heads to the West. :'
  four8: 'A wild twerk team appears, and chases you from the East! :'
  three8: 'You see burnt trees leading east... the huge ass dragon must have gone this way. :'
  two8: 'WTF? All of the trees disappeared. You are now in a solid black room. A purple portal to the north appears withsign that reads \'The Turn Up is Real\''
  two7: 'Wow you found the dragon! Good job turn the fuck up.'
