local physics = require("physics");
local display = require("display");
local timer = require("timer");

physics.start()

local highest_score = 0;
local highest_score_text = display.newText({
	text = "Рекорд: " .. highest_score,
	fontSize = 14,
	x = display.contentCenterX - display.contentCenterX / 2
});

local score = 0;
local text = display.newText({
	text = "Счет: " .. score,
	fontSize = 14,
	x = display.contentCenterX + display.contentCenterX / 2
});

local screenWidth = display.contentWidth
local screenHeight = display.contentHeight

local trigger = display.newCircle(display.contentCenterX, display.contentCenterY + display.contentCenterY / 2, 20);

local objectLeft = 0
local objectRight = screenWidth
local objectTop = 0
local objectBottom = screenHeight

trigger:setFillColor(0.5, 0.5, 1)
trigger:addEventListener("touch", function(event)
	if event.phase == "began" then
		display.currentStage:setFocus(trigger);
		trigger.touchOffsetX = event.x - trigger.x;
		trigger.touchOffsetY = event.y - trigger.y;
	end;
	if event.phase == "moved" then
		local x = event.x
		local y = event.y
		if x < objectLeft then
		  x = objectLeft
		elseif x > objectRight then
		  x = objectRight
		end
		if y < objectTop then
		  y = objectTop
		elseif y > objectBottom then
		  y = objectBottom
		end
		trigger.x, trigger.y = x, y
	  end
	if event.phase == "ended" or event.phase == "cancelled" then
		display.currentStage:setFocus(nil);
	end;
end);
trigger:addEventListener("collision", function (event)
	if event.phase == "began" then
		if event.other.isSensor ~= true then
			if event.other.ID == "red" then
				if score > highest_score then
					highest_score = score
					highest_score_text.text = "Рекорд: " .. highest_score
				end
				
				score = 0
				text.text = "Счет: " .. score
			end

			if event.other.ID == "blue" then
				score = score + 1
				text.text = "Счет: " .. score
			end

			if event.other.ID == "green" then
				score = score + 5
				text.text = "Счет: " .. score
			end

			event.other:removeSelf()
		end
	end
end)
physics.addBody(trigger, "static");

local bucket = display.newRect(display.contentCenterX, display.contentCenterY * 2 + 18, display.actualContentWidth, 1);
bucket:addEventListener("collision", function (event)
	if event.phase == "began" then
		if event.other.isSensor ~= true then
			event.other:removeSelf()
		end
	end
end)
physics.addBody(bucket, "static");

timer.performWithDelay(1000, function()
	local circle = display.newCircle(math.random(50, display.contentWidth - 50), -50, 25);

	local randomColor = math.random(1, 3)
	if randomColor == 1 then
		circle:setFillColor(1, 0, 0)
		circle.ID = "red"
	elseif randomColor == 2 then
		circle:setFillColor(0, 0, 1)
		circle.ID = "blue"
	else
		circle:setFillColor(0, 1, 0)
		circle.ID = "green"
	end

	physics.addBody(circle, "dynamic", { isSensor = true });
end, 0);
