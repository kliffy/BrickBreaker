display.setStatusBar(display.HiddenStatusBar);
local physics = require 'physics';
physics.start();
physics.setGravity(0,0);

--Set Up Ball
local ball = display.newImage('ball.png');
ball.y = 30;
physics.addBody(ball);

print(display.contentHeight);

--Set Up Walls
local leftWall = display.newImage('sideWall.png', true);
leftWall.x = leftWall.width;
physics.addBody(leftWall, 'static', {bounce = 1});

print(leftWall.height);
print(leftWall.width);

local rightWall = display.newImage('sideWall.png', true);
rightWall.x = display.contentWidth - rightWall.width;
physics.addBody(rightWall, 'static', {bounce = 1});

local topWall = display.newImage('topWall.png', true);
topWall.y = topWall.height;
physics.addBody(topWall, 'static', {bounce = 1});

local bottomWall = display.newImage('topWall.png', true);
bottomWall.y = display.contentHeight - bottomWall.height;
physics.addBody(bottomWall, 'static', {bounce = 1});

local xVelocity = 10;

ball:setLinearVelocity(300,200);





-- ySpeed = 8;
-- xSpeed = 8;
-- yTranslation = 1;
-- xTranslation = 1;

-- local yTopWall = ball.y;
-- local yBottomWall = display.actualContentHeight - ball.y;

-- local xLeftWall = ball.x;
-- local xRightWall = display.actualContentWidth - ball.x;

-- function move()
-- 	if ball.y == yBottomWall then
-- 		yTranslation = -1;
-- 	elseif ball.y == yTopWall then
-- 		yTranslation = 1;
-- 	end

-- 	if ball.x == xLeftWall then
-- 		xTranslation = 1;
-- 	elseif ball.x == xRightWall then
-- 		xTranslation = -1;
-- 	end

-- 	ball:translate(xSpeed * xTranslation, ySpeed * yTranslation);
-- end

--timer.performWithDelay(1, move, -1);

-- function blah(event)
-- 	transition.to(ball, {time=100, x=event.x, y=event.y})
-- end

-- Runtime:addEventListener('touch', blah);