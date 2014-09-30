fonts = {}

function fonts:load()
	fonts["default"] = love.graphics.newFont(14)
end

function fonts:use(id)
	if not id then id = "default" end
	love.graphics.setFont(fonts[id])
end

hook:add("load", fonts.load)
hook:add("draw-2", fonts.use)
return fonts