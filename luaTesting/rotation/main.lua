function love.load()
	arrow = {}
	arrow.x = 300
	arrow.y = 300
	arrow.w = 50
	arrow.h = 100
	arrow.image = love.graphics.newImage("arrow.png")
	angle = 0
end

function love.update(dt)
	angle = angle + dt
end

function love.draw()
	love.graphics.push()
	-- love.graphics.translate(-arrow.x, -arrow.y)
	love.graphics.rotate(angle)
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(arrow.image, arrow.x - arrow.w/2, arrow.y - arrow.h/2)
	love.graphics.setColor(1, 0, 0)
	love.graphics.origin()
	love.graphics.pop()
	love.graphics.draw(arrow.image, 100, 100)
	love.graphics.circle("fill", arrow.x, arrow.y, 1)
end











