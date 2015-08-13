-- display settings and configuration
screen = {}

-- configuration variables (can be overriden)
screen.width  = 800
screen.height = 600
screen.flags  = {}
screen.title  = "Warzone Command " .. VER

-- (re)initializes the graphics display
function screen:load()
  love.window.setMode(screen.width, screen.height, screen.flags)
  love.window.setTitle(screen.title)
end

return screen