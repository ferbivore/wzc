-- keeps a list of "hook" functions and executes them on command
local hook = {}

-- a table of sets, at least conceptually
hook.hooks = {}

-- add a function to a given hook
function hook:add(key, func, id)
	if not hook.hooks[key] then
		hook.hooks[key] = {}
	end
	if not hook.hooks[key][func] then
		hook.hooks[key][func] = true
	end
end

-- run all functions for a given hook
-- warning: order is probably non-deterministic
function hook:run(key, ...)
	if hook.hooks[key] then
		for func, _ in pairs(hook.hooks[key]) do
			func(...)
		end
	end
end

-- remove a function
function hook:remove(key, func)
	if hook.hooks[key] then
		hook.hooks[key][func] = nil
	end
end

return hook