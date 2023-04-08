local physics = require("physics")
local display = require("display")
local timer = require("timer")

physics.start()

local text = display.newText("Счет:", 0, 30, "Welvetica", 40)

local x = 0
local score = display.newText(x, 70, 30, "Welvetica", 40)

local ball = display.newImageRect("../../../../Downloads/big_zyzzbrah_1.png", 50, 50)
physics.addBody(ball, "dynamic")

local lower_border = display.newRect(0, 320, 590, 1)
physics.addBody(lower_border, "static")

local button = display.newCircle(-50, 320, 110)
button:setFillColor(0)
button:addEventListener("tap", function () ball:applyLinearImpulse(0.0, -0.1, ball.x, ball.y) end)

timer.performWithDelay(2000, function()
    local y = math.random(100, 200)

	local upper_gate = display.newRect(700, y - 150, 50, 150)
	upper_gate.ID = "upper_gate"
	local pass_gate = display.newRect(700, y, 50, 150)
	pass_gate.ID = "pass_gate"
	local lower_gate = display.newRect(700, y + 150, 50, 150)
	lower_gate.ID = "lower_gate"

	physics.addBody(upper_gate, "dynamic", { isSensor = true })
	physics.addBody(pass_gate, "dynamic", { isSensor = true })
	physics.addBody(lower_gate, "dynamic", { isSensor = true })
 
	upper_gate.gravityScale = 0
	pass_gate.gravityScale = 0
	lower_gate.gravityScale = 0

	upper_gate:setLinearVelocity(-100, 0)
	pass_gate:setLinearVelocity(-100, 0)
	lower_gate:setLinearVelocity(-100, 0)

	upper_gate:setFillColor(1,1,1)
	pass_gate.alpha = 0
	lower_gate:setFillColor(1,1,1)

    timer.performWithDelay(9000, function ()
    	upper_gate:removeSelf()
    	pass_gate:removeSelf()
		lower_gate:removeSelf()
    end)
end, 0)

ball.collision = function (self, event)
	if (event.phase == "began" and event.other.ID == "pass_gate") then
		x = x + 1
		score.text = x
	end

	if event.phase == "began" and (event.other.ID == "upper_gate" or event.other.ID == "lower_gate") then
		physics.pause()
		local loseeeer = display.newText("Loseeeer", 230, 170, "Welvetica", 40)
		loseeeer:setFillColor(1,0,0)
	end
end
ball:addEventListener("collision", ball)
