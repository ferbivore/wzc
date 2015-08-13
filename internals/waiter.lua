-- helper functions for postponing actions
waiter = {}

-- array for the current waiters
waiter.waiters = {}

-- add a waiter (runs the specified function after the specified time)
function waiter:add(func, wtime)
  w = {func=func, ttime=(love.timer.getTime() + wtime)}
  table.insert(waiter.waiters, w)
end

-- processes all current waiters
function waiter:run()
  ctime = love.timer.getTime()
  for index, w in pairs(waiter.waiters) do
    if w.ttime <= ctime then
      w.func()
      table.remove(waiter.waiters, index)
    end
  end
end

-- return module
return waiter