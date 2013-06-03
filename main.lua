local myTextObject = display.newText('.', 0, 0, 'Arial', 60);
myTextObject:setTextColor( 255, 0, 0 );

ySpeed = 8;
xSpeed = 8;
yTranslation = 1;
xTranslation = 1;

local yTopWall = myTextObject.y;
local yBottomWall = display.actualContentHeight - myTextObject.y;

local xLeftWall = myTextObject.x;
local xRightWall = display.actualContentWidth - myTextObject.x;

function move()
	if myTextObject.y == yBottomWall then
		yTranslation = -1;
	elseif myTextObject.y == yTopWall then
		yTranslation = 1;
	end

	if myTextObject.x == xLeftWall then
		xTranslation = 1;
	elseif myTextObject.x == xRightWall then
		xTranslation = -1;
	end

	myTextObject:translate(xSpeed * xTranslation, ySpeed * yTranslation);
end

timer.performWithDelay(1, move, -1);