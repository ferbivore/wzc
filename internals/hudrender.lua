-- HUD element rendering - tooltips, crosshairs, selectors, etc.
-- (comms section handled by internals/comms independently)
hudrender = {}

-- crosshair - acts as mouse cursor
hudrender.crosshair = {}
-- hides mouse cursor (needs to be run once)
function hudrender.crosshair:load()
  love.mouse.setVisible(false)
end
-- draws crosshair
function hudrender.crosshair:draw()
  love.graphics.setColor(50, 200, 50)
  love.graphics.setLineWidth(1)
  local x, y = love.mouse.getPosition()
  love.graphics.line(x, y-30, x, y+30)
  love.graphics.line(x-30, y, x+30, y)
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


return hudrender