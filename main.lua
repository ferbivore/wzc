VER = "0.2.2"

-- loads modules and overrides love's main callback functions
screen  = require "internals/screen"
waiter  = require "internals/waiter"
fonts   = require "internals/fonts"
textbox = require "internals/textbox"
hud     = require "internals/hud/hud"
map     = require "internals/map/map"

function love.load()
  screen:load()
  fonts:load()
  hud:load()
  -- testing
  maprender:loadmap(maprender.TESTMAP)
  waiter:add(function() comms:add("WZC version "..VER.." loaded.", comms.DEBUG) end, 0)
  waiter:add(function() comms:add("ALPHA-1 REPORTING IN, GRID 552466") end, 3)
  waiter:add(function() comms:add("BASE TO ALPHA-1, 10-4", comms.BASE) end, 5)
end

function love.update(dt)
  hud:update()
  maprender.pan:update()
  waiter:run()
end

function love.draw()
  fonts:use()
  maprender:draw()
  hud:draw()
end

function love.mousepressed(x, y, button)
  -- map panning
  if button == "r" then
    maprender.pan:start(x, y)
  end
end

function love.mousereleased(x, y, button)
  -- map panning
  if button == "r" then
    maprender.pan:stop()
  end
end

-- TODO LIST:
--  game state data storage
--  [DONE] map rendering
--  [DONE] map panning
--  map zoom on cursor
--  mouse input
--  keyboard input
--  unit selection (by keyboard and mouse)
--  unit preview (on mouseover)
--  primitive unit movement
--  map props
--  map elevation
--  pathfinding
--  elevation dependent speed
--  unit line of sight
--  forests and other cover types
--  squads
--  more squad/unit commands
--  squad/unit AI
--  AI modes (offensive, defensive)
--  enemy command AI
-- POSSIBLY ON TODO LIST:
--  module loader with hooks and dependency resolution
-- SOURCE CODE ORGANIZATION TODO LIST:
--  move todo list into a separate file/wiki/bugtracker
--  add some sort of license
--  add some sort of readme