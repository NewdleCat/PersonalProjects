io.stdout:setvbuf("no")


function love.load()
	love.window.setMode(1600, 900)
	tileSize = 5
	scl = 0.05
	seed = love.timer.getTime()

	pausedState = false
	colorState = true
end

function love.update(dt)
	-- print(love.graphics.getWidth())

	-- print(love.math.noise(1))
	-- print(love.timer.getTime())
	-- seed = love.timer.getTime()
	if pausedState then
		seed = seed + dt
	end
end

function love.draw()
	for i = 0, love.graphics.getWidth()/tileSize do
		for j = 0, love.graphics.getHeight()/tileSize do
			noise = love.math.noise(i * scl, j * scl, seed)
			-- noise = OctaveNoise(i * scl, j * scl, 4, seed)
			color = getColor(noise)
			if colorState then
				love.graphics.setColor(unpack(color))
			else
				love.graphics.setColor(noise, noise, noise)
			end
			love.graphics.rectangle("fill", i * tileSize, j * tileSize, tileSize, tileSize)
		end
	end
end

function OctaveNoise(x,y, octaves, seed1)
    local ret = 0

    local freq = 1
    local amp = 1
    local ampTot = 0
    for i=1, octaves do
        ret = ret + love.math.noise(x*freq + seed1, y*freq + seed1)*amp
        freq = freq * 0.5
        ampTot = ampTot + amp
        amp = amp * 2
    end

    -- convert to 0-1
    ret = (ret/ampTot)

    return ret
end

function love.keypressed(key)
	if key == "space" then
		-- print("HEY")
		pausedState = not pausedState
	end

	if key == "r" then
		seed = love.timer.getTime()
	end

	if key == "t" then
		colorState = not colorState
	end

	if key == "right" then
		tileSize = tileSize + 1
	elseif key == "left" then
		if tileSize > 1 then
			tileSize = tileSize - 1
		end
	end

	if key == "up" then
		scl = scl - 0.05
	elseif key == "down" then
		scl = scl + 0.05
	end
end

function getColor(noise)

	--FOREST COLORS
	-- if noise < 0.3 then -- water
	-- 	return {0/255, 178/255, 255/255}
	-- elseif noise < 0.4 then -- sand
	-- 	return {255/255, 201/255, 0/255}
	-- elseif noise < 0.7 then -- grass
	-- 	return {181/255, 255/255, 0/255}
	-- else -- forest
	-- 	return {57/255, 104/255, 32/255}
	-- end

	-- OCEAN ISLAND COLORS
	if noise < 0.4 then -- deep water
		return {0/255, 93/255, 255/255}
	elseif noise < 0.6 then -- water
		return {0/255, 178/255, 255/255}
	elseif noise < 0.7 then -- sand
		return{255/255, 182/255, 0/255}
	else  -- grass
		return {108/255, 255/255, 0/255}
	-- elseif noise < 0.9 then
	-- 	return{0, 0, 0}
	-- else
	-- 	return{0, 0, 0}
	end
end