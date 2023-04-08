	local physics = require("physics")
physics.start()

local function randCoordinates()
	local y = math.random(0, 20)
	local x = math.random(0, 30)
	return x, y
end

local borderUp = display.newRect(160, -90, 320, 0)
physics.addBody(borderUp, "static")

local borderDown = display.newRect(160, 590, 320, 0)
physics.addBody(borderDown, "static")

local borderLeft = display.newRect(0, 240, 590, 0)
physics.addBody(borderLeft, "static")
borderLeft:rotate(90)

local borderRight = display.newRect(320, 250, 590, 0)
physics.addBody(borderRight, "static")
borderRight:rotate(90)

local x1, y1 = randCoordinates()
local border1 = display.newRect(90 + x1, 250 + y1, 180, 10)
physics.addBody(border1, "static")
border1:rotate(math.random(-15, 15))

local x2, y2 = randCoordinates()
local border2 = display.newRect(230 + x2, 130 + y2, 180, 10)
physics.addBody(border2, "static")
border2:rotate(math.random(-15, 15))

local x3, y3 = randCoordinates()
local border3 = display.newRect(90 + x3, 30 + y3, 180, 10)
physics.addBody(border3, "static")
border3:rotate(math.random(-15, 15))

local balloon = display.newCircle(160, 360, 30)
physics.addBody(balloon, "dynamic")
balloon.gravityScale = math.random(-1, 1)

--[[
	x, y, width, height

	x, y states for center of rectangle
]]
local leftRectangle = display.newRect(60, 530, 140, 70)
local rightRectangle = display.newRect(260, 530, 140, 70)
physics.addBody(leftRectangle, "static")
physics.addBody(rightRectangle, "static")
leftRectangle:rotate(45)
rightRectangle:rotate(-45)

local function pushLeft()
	balloon:applyLinearImpulse(0.1, -0.2, balloon.x, balloon.y)
end

local function pushRight()
	balloon:applyLinearImpulse(-0.1, -0.2, balloon.x, balloon.y)
end

leftRectangle:addEventListener("tap", pushLeft)
rightRectangle:addEventListener("tap", pushRight)
