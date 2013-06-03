display.setStatusBar(display.HiddenStatusBar);
local physics = require 'physics';
physics.start();
physics.setGravity(0,0);


--Set Up Platform
local platform = display.newImage('platform.png');
platform.x = 100;
platform.y = display.contentHeight - 30;
physics.addBody(platform, 'static', {bounce = 1});


--Set Up Ball
local ball = display.newImage('ball.png');
ball.y = platform.y - 30;
ball.x = 100;
physics.addBody(ball);


--Set Up Walls
local leftWall = display.newImage('sideWall.png', true);
leftWall.x = -leftWall.width;
physics.addBody(leftWall, 'static', {bounce = 1});

local rightWall = display.newImage('sideWall.png', true);
rightWall.x = display.contentWidth + rightWall.width;
physics.addBody(rightWall, 'static', {bounce = 1});

local topWall = display.newImage('topWall.png', true);
topWall.y = -topWall.height;
physics.addBody(topWall, 'static', {bounce = 1});

local bottomWall = display.newImage('topWall.png', true);
bottomWall.y = display.contentHeight;
physics.addBody(bottomWall, 'static', {bounce = 1});



--Set Up Blocks
--THIS NEEDS TO BE SET UP MANUALLY FOR EACH LEVEL... or does it?
print(display.contentWidth);

columns = 7;
blocksPerRow = display.contentWidth/40;

for y = 1, columns, 1 do
	for i = 0, blocksPerRow - 1, 1 do
		local block = display.newImage('block.png', true);
		block.x = (i * 40) + block.width/2;
		block.y = 150 + (y * block.height);
		physics.addBody(block, 'static', {bounce = 1});
		block.name = 'block';
	end
end








--Set up ability to move platform
function movePlatform(event)
	if event.phase == 'moved' then
		transition.to(platform, {time = 50, x = event.x})
	end
end
Runtime:addEventListener('touch', movePlatform);








ball:setLinearVelocity(300,200);


local function ballCollision(self, event)
	if event.phase == 'began' then
		if event.other.name == 'block' then
			event.other:removeSelf();
		elseif event.other == platform then
			--increase velocity
		elseif event.other == bottomWall then
			--lose the game
		end

		--if it hits a block... then...
	end
end

ball.collision = ballCollision
ball:addEventListener('collision', ball);

