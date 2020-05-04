# Configuration:
#   HUBOT_WHITELIST
#   HUBOT_WHITELIST_PATH

reach = require('@hapi/hoek').reach
path = require('path')

module.exports = (robot) ->

  # Establish whitelist
  whitelist = []
  if process.env.HUBOT_WHITELIST
    whitelist = process.env.HUBOT_WHITELIST.split(',')
  else if process.env.HUBOT_WHITELIST_PATH
    whitelist = require(path.resolve(process.env.HUBOT_WHITELIST_PATH))

  unless Array.isArray(whitelist)
    robot.logger.error 'whitelist is not an array!'

  robot.receiveMiddleware (context, next, done) ->
    # Unless the room is in the whitelist
    unless reach(context, 'response.envelope.room') in whitelist
     # Remove the slack formatting
    return unless context.plaintext?
    context.strings = (String.raw`word`) for word in context.strings)
      if context.response.message.text != undefined
        if context.response.message.text.substring(0,7)==robot.name.toLowerCase()
          context.response.reply 'Sorry, ' + robot.name + ' is not supported on this channel'
      context.response.message.finish()
      done()
    else
      next(done)