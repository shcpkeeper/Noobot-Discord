discordie = require 'discordie'
config = require './config'
if isnt config.token then throw "EDIT CONFIG.COFFEE!"

client = new discordie autoReconnect:yes

client.connect token: config.token

client.Dispatcher.on "GATEWAY_READY", (e) ->
  a = e.User.getApplication()
  bot =
    id = e.User.id
    username = e.User.username
    avatarURL = e.User.avatarURL
    inviteURL = "https://discordapp.com/api/oauth2/authorize?client_id=#{a.id}&scope=bot&permissions=0"
  startup = new Date()
  console.log "[INFO] Connected as #{bot.username}"
  console.log "[INFO] Invite URL : #{bot.inviteURL}"


client.Dispatcher.on "DISCONNECTED", (e) ->
  if e.error is "Login failed" then console.log "[INFO] Failed to connect! Retrying..." else console.log "[INFO] Disconnected! Trying to reconnect..."

client.Dispatcher.on "GATEWAY_RESUMED", (e) ->
  console.log "[INFO] Reconnected!"
