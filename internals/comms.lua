textbox = require "internals/textbox"

-- holds comms (chat) messages, draws and clears them after a timeout
-- allows adding comms messages (but not removing)
comms = {}

-- define an array for the messages and a default timeout (in seconds)
comms.messages = {}
comms.timeout  = 8
-- color constants
comms.DEBUG = "magenta"
comms.UNIT  = "green"
comms.BASE  = "red"

-- form a message object and add it to the messages table
function comms:add(message, color)
  imsg = { text=message, color=(color or comms.UNIT), rtime=love.timer.getTime() }
  table.insert(comms.messages, imsg)
end

-- prunes messages that have reached their timeout
-- to be called periodically (from love.update or similar)
function comms:update()
  ctime = love.timer.getTime()
  for index, message in ipairs(comms.messages) do
    if (message.rtime + comms.timeout) <= ctime then
      table.remove(comms.messages, index)
    end
  end
end

-- draws the current messages on screen
-- uses internals/textbox to do the actual drawing
function comms:draw()
  for index, message in ipairs(comms.messages) do
    y_neg_offset = index * textbox:getHeight()
    textbox:cdraw(0, (screen.height - y_neg_offset), message.color, message.text)
  end
end

return comms