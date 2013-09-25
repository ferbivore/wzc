-- display settings and configuration
screen = {}

-- configuration variables (can be overriden)
screen.width      = 1280
screen.height     = 768
screen.fullscreen = false
screen.vsync      = false -- vsync makes it laggier
screen.msaa       = 0

-- (re)initializes the graphics display
function screen:init()
  love.graphics.setMode(screen.width, screen.height, screen.fullscreen, screen.vsync, screen.msaa)
end

-- module metadata
screen.MODULE_HOOKS = {
  ["love.load"] = screen.init
}

return screen