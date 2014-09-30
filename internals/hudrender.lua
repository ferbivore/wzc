textbox = require "internals/textbox"

-- HUD element rendering - tooltips, crosshairs, selectors, etc.
-- (comms section handled by internals/comms independently)
hudrender = {}

-- crosshair colours
hudrender.colors = {
  green   = { 50, 200, 50 },
  red     = { 180, 0, 0 },
  magenta = { 200, 100, 200 }
}
hudrender.default_color = "green"
hudrender.color = hudrender.colors[hudrender.default_color]

-- crosshair - acts as mouse cursor
hudrender.crosshair = {}
-- hides mouse cursor (needs to be run once)
function hudrender.crosshair:load()
  love.mouse.setVisible(false)
end
-- draws crosshair
function hudrender.crosshair:draw()
  love.graphics.setColor(hudrender.color)
  love.graphics.setLineWidth(1)
  local x, y = love.mouse.getPosition()
  love.graphics.line(x, y-30, x, y+30)
  love.graphics.line(x-30, y, x+30, y)
end

-- color
function hudrender.crosshair:setColor(colorstring)
  hudrender.color = hudrender.colors[colorstring]
end

-- tooltip - always under mouse cursor, only one per screen
hudrender.tooltip = { active = false, text = nil }
-- draws tooltip 2 pixels under and to the right of the cursor position
function hudrender.tooltip:draw()
  if hudrender.tooltip.active then
    textbox:draw(love.mouse.getX()+2, love.mouse.getY()+2, hudrender.tooltip.text)
  end
end
-- sets tooltip
function hudrender.tooltip:set(text)
  hudrender.tooltip.text = text
  hudrender.tooltip.active = true
end
-- unsets tooltip
function hudrender.tooltip:unset()
  hudrender.tooltip.active = false
end

-- main functions, to be called from love.*
function hudrender:load()
  hudrender.crosshair:load()
end
function hudrender:draw()
  hudrender.crosshair:draw()
  hudrender.tooltip:draw()
end


return hudrender