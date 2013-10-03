-- renders the game map and all objects on it (with correct panning and scaling)
maprender = {}

-- variables
maprender.map  = nil
maprender.pan = { active=false, ix=0, iy=0, x=0, y=0 }

-- test map
maprender.TESTMAP = {
  geometry = { width = 1000, height = 1000 },
  props = {
    strongholds = {
      { x = 420, y = 305, d = -45 }
    },
    buildings = {
      { x = 780, y = 500, w = 50, h = 30, d = 35 }
    }
  },
  squads = {
    alpha = {
      units = {
        { x = 552, y = 466, d = 106, rank = "officer", vehicle = nil }
      },
      vehicles = {}
    }
  }
}

-- load a map (todo: formally define map format) and generate drawable map
function maprender:loadmap(map)
  maprender.map = map
  maprender.pan.x = 0
  maprender.pan.y = 0
end

-- draw a given map at (0,0)
function maprender:drawmap(map)
  local mw = map.geometry.width
  local mh = map.geometry.height
  -- draw the light gray map square
  love.graphics.setColor(230, 230, 230)
  love.graphics.rectangle("fill", 0, 0, mw, mh)
end

-- draw the current map centered on the screen (wraps drawmap())
function maprender:draw()
  local map = maprender.map
  local pan = maprender.pan
  local sw = screen.width
  local sh = screen.height
  local mw = map.geometry.width
  local mh = map.geometry.height
  -- save, then translate coordinate system:
  --  first, to the center of the screen (sw/2, sh/2)
  --  then, to the starting position of the map (-(mw/2)+pan.x, -(mh/2)+pan.y)
  -- then draw map at (0,0) and revert coordinate system
  -- (this will draw the map centered on the screen)
  love.graphics.push()
  love.graphics.translate(sw/2, sh/2)
  love.graphics.translate(-(mw/2)+pan.x, -(mh/2)+pan.y)
    maprender:drawmap(map)
  love.graphics.pop()
end

function maprender.pan:start(x,y)
  -- I'm not really sure how to comment this...
  -- basically, we set a starting point for the pan delta calculation
  -- (mouse coords, minus current pan delta)
  maprender.pan.ix = x - maprender.pan.x
  maprender.pan.iy = y - maprender.pan.y
  maprender.pan.active = true
end

function maprender.pan:stop()
  maprender.pan.active = false
end

function maprender.pan:update()
  if maprender.pan.active then
    -- set the new pan delta (mouse coords, minus starting point for delta calculation)
    -- this effectively moves the starting position for the map draw (see maprender:draw())
    maprender.pan.x = love.mouse.getX() - maprender.pan.ix
    maprender.pan.y = love.mouse.getY() - maprender.pan.iy
  end
end

-- module metadata
maprender.MODULE_DEPS = { "internals/proprender" }
maprender.MODULE_HOOKS = {
}

return maprender