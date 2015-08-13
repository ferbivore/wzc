textbox = require "internals/textbox"
comms   = require "internals/hud/comms"

-- HUD element rendering - tooltips, crosshairs, selectors, etc.
-- (comms section handled by internals/comms independently)
hud = {}

-- crosshair colours
hud.colors = {
  green   = { 50, 200, 50 },
  red     = { 180, 0, 0 },
  magenta = { 200, 100, 200 }
}
hud.default_color = "green"
hud.color = hud.colors[hud.default_color]

-- crosshair - acts as mouse cursor
hud.crosshair = {}
-- hides mouse cursor (needs to be run once)
function hud.crosshair:load()
  love.mouse.setVisible(false)
end
-- draws crosshair
function hud.crosshair:draw()
  love.graphics.setColor(hud.color)
  love.graphics.setLineWidth(1)
  local x, y = love.mouse.getPosition()
  love.graphics.line(x, y-30, x, y+30)
  love.graphics.line(x-30, y, x+30, y)
end

-- color
function hud.crosshair:setColor(colorstring)
  hud.color = hud.colors[colorstring]
end

-- tooltip - always under mouse cursor, only one per screen
hud.tooltip = { active = false, text = nil }
-- draws tooltip 2 pixels under and to the right of the cursor position
function hud.tooltip:draw()
  if hud.tooltip.active then
    textbox:draw(love.mouse.getX()+2, love.mouse.getY()+2, hud.tooltip.text)
  end
end
-- sets tooltip
function hud.tooltip:set(text)
  hud.tooltip.text = text
  hud.tooltip.active = true
end
-- unsets tooltip
function hud.tooltip:unset()
  hud.tooltip.active = false
end

-- main functions, to be called from love.*
function hud:load()
  hud.crosshair:load()
end
function hud:draw()
  comms:draw()
  hud.crosshair:draw()
  hud.tooltip:draw()
end
function hud:update()
  comms:update()
end

return hud