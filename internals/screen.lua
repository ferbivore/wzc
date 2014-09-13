-- display settings and configuration
screen = {}

-- configuration variables (can be overriden)
screen.width  = 800
screen.height = 600
screen.flags  = {}

-- (re)initializes the graphics display
function screen:init()
  love.window.setMode(screen.width, screen.height, screen.flags)
end

-- module metadata
screen.MODULE_HOOKS = {
  ["love.load"] = screen.init
}

return screen