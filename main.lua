VER = "0.2.0"
CHANGELOG = "Refactored and modularized everything."

-- loads modules and exposes love's main callback functions

screen    = require "internals/screen"
waiter    = require "internals/waiter"
textbox   = require "internals/textbox"
comms     = require "internals/comms"
maprender = require "internals/maprender"
hudrender = require "internals/hudrender"

function love.load()
  -- pre-module-load configuration
  love.graphics.setCaption("Warzone Command "..VER) -- will be deprecated in love 0.9.0
  default_font = love.graphics.newFont(14)
  -- modules
  screen:init()
  hudrender.crosshair:load()
  waiter:add(function() comms:add("WZC version "..VER.." loaded.", comms.DEBUG) end, 0)
  -- testing
  maprender:loadmap(maprender.TESTMAP)
  waiter:add(function() comms:add("ALPHA-1 REPORTING IN, GRID 552466") end, 3)
  waiter:add(function() comms:add("BASE TO ALPHA-1, 10-4", comms.BASE) end, 5)
  hudrender.tooltip:set("ALPHA-1 [OFFICER]")
end

function love.update(dt)
  -- modules
  waiter:run()
  maprender.pan:update()
  comms:update()
end

function love.draw()
  -- pre-module-load configuration
  love.graphics.setFont(default_font)
  -- modules
  maprender:draw()
  comms:draw()
  hudrender.crosshair:draw()
  -- testing
  hudrender.tooltip:draw()
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
--  map panning
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