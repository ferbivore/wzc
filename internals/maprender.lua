-- renders the game map and all objects on it (with correct panning and scaling)
maprender = {}

-- variables (current map and drawable map)
maprender.map  = nil
maprender.dmap = nil

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
  --maprender.dmap = {
  --  width  = map.geometry.width,
  --  height = map.geometry.height,
  --  x      = map.geometry.width/2,
  --  y      = map.geometry.height/2,
  --}
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
  local sw = screen.width
  local sh = screen.height
  local mw = map.geometry.width
  local mh = map.geometry.height
  -- save, then translate coordinate system:
  --  first, to the center of the screen (sw/2, sh/2)
  --  then, to the starting position of the map (-(mw/2), -(mh/2))
  -- then draw map at (0,0) and revert coordinate system
  love.graphics.push()
  love.graphics.translate(sw/2, sh/2)
  love.graphics.translate(-(mw/2), -(mh/2))
    maprender:drawmap(map)
  love.graphics.pop()
end



-- module metadata
maprender.MODULE_DEPS = { "internals/proprender" }
maprender.MODULE_HOOKS = {
}

return maprender