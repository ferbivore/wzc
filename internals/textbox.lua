-- handles drawing of on-screen textboxes (simple text on opaque background)
textbox = {}

-- constants
textbox.pad = 4
textbox.colors = {
  green   = { bg = {0,100,0},  fg = {0,255,0} },
  red     = { bg = {100,0,0},  fg = {255,0,0} },
  magenta = { bg = {20,20,20}, fg = {200,100,200} }
}
textbox.default_color = "green"
-- variables
textbox.bgcolor = textbox.colors[textbox.default_color].bg
textbox.fgcolor = textbox.colors[textbox.default_color].fg

-- returns eventual height of textbox
function textbox:getHeight() return love.graphics.getFont():getHeight() + 2*textbox.pad end

-- returns eventual width of textbox, given a string of text
function textbox:getWidth(text) return love.graphics.getFont():getWidth(text) + 2*textbox.pad end

-- sets the text colors to be one of several defaults:
--  "green"   is used for messages from units
--  "red"     is used for messages from base
--  "magenta" is used for game debugging messages
function textbox:setColors(colorstring)
  textbox.bgcolor = textbox.colors[colorstring or "green"].bg
  textbox.fgcolor = textbox.colors[colorstring or "green"].fg
end

-- resets the text colors to the defaults (shorthand)
function textbox:resetColors() textbox:setColors() end

-- draw a padded textbox, specifying x, y and one or more strings
-- (supports drawing multiple stacked textboxes)
function textbox:draw(x, y, ...)
  for index, text in ipairs({...}) do
    ay = y + (index-1)*textbox:getHeight()  -- get the actual height of the box
    love.graphics.setColor(textbox.bgcolor)
    love.graphics.rectangle("fill", x, ay, textbox:getWidth(text), textbox:getHeight())
    love.graphics.setColor(textbox.fgcolor)
    love.graphics.print(text, x + textbox.pad, ay + textbox.pad)
  end
end

-- draw a padded textbox, specifying x, y, a color string and one or more strings
-- same as previous function, but with easy support for colors
function textbox:cdraw(x, y, colorstring, ...)
  textbox:setColors(colorstring)
  textbox:draw(x, y, ...)
  textbox:resetColors()
end

return textbox