fonts = {}

function fonts:load()
	fonts["default"] = love.graphics.newFont(14)
end

function fonts:use(id)
	if not id then id = "default" end
	love.graphics.setFont(fonts[id])
end

return fonts