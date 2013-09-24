-- helper functions for postponing actions
waiter = {}

waiter.waiters = {}

function waiter:add(func, wtime)
  w = {func=func, ttime=(love.timer.getTime() + wtime)}
  table.insert(waiter.waiters, w)
end

function waiter:run()
  ctime = love.timer.getTime()
  for index, w in pairs(waiter.waiters) do
    if w.ttime <= ctime then
      w.func()
      table.remove(waiter.waiters, index)
    end
  end
end

-- module metadata
waiter.MODULE_HOOKS = {
  ["love.update"] = waiter.run,
}

return waiter