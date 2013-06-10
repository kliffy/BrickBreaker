display.setStatusBar(display.HiddenStatusBar)
local physics = require 'physics'
physics.start()
physics.setGravity(0, 0)


local BRICK_WIDTH = 32
local BRICK_HEIGHT = 14
local Y_BRICK_OFFSET_FROM_TOP = 20
local COLUMNS = 10
local SCORE_CONST = 100
local score = 0
local bricks = display.newGroup()
local gameEvent = ''
local currentLevel = 1

-- starting ball velocity
local xVelocity = 200
local yVelocity = 200

-- menu screen
local background = display.newImage('bg.png')
local menuScreen
local menuScreanBackground
local startButton
local aboutButton

-- about screen
local aboutScreen

-- game screen
local paddle
local brick
local ball
local leftWall
local rightWall
local topWall
local bottomWall

-- score and level text
local scoreText
local scoreNum
local levelText
local levelNum

-- alert screen
local alertScreen
local alertBg
local box
local titleTF
local msgTF


-- levels
local levels = {}

levels[1] = {
             {0,0,0,0,0,0,0,0,0,0},
             {0,0,0,0,0,0,0,0,0,0},
             {0,0,0,0,0,0,0,0,0,0},
             {0,0,0,0,0,0,0,0,0,0},
             {0,0,0,0,0,0,0,0,0,0},
             {0,0,0,0,0,0,0,0,0,0},
             {0,0,0,0,0,0,0,0,0,0},
             {0,0,0,0,0,0,0,0,0,0},
             {0,0,0,0,0,0,0,1,0,0},
           }

levels[2] = {
             {1,1,1,1,0,0,1,1,1,1},
             {1,1,1,1,0,0,1,1,1,1},
             {1,1,1,1,0,0,1,1,1,1},
             {1,1,1,1,0,0,1,1,1,1},
             {1,1,1,1,0,0,1,1,1,1},
             {1,1,1,1,0,0,1,1,1,1},
             {1,1,1,1,0,0,1,1,1,1},
             {1,1,1,1,0,0,1,1,1,1},
             {1,1,1,1,0,0,1,1,1,1},
             {1,1,1,1,0,0,1,1,1,1},
             {1,1,1,1,0,0,1,1,1,1},
             {1,1,1,1,0,0,1,1,1,1},
             {1,1,1,1,0,0,1,1,1,1},
             {1,1,1,1,0,0,1,1,1,1},
             {1,1,1,1,0,0,1,1,1,1},
             {1,0,0,0,0,0,0,0,0,1},
             {1,0,0,0,0,0,0,0,0,1},
             {1,0,0,0,0,0,0,0,0,1},
             {1,0,0,0,0,0,0,0,0,1},
             {1,1,1,1,0,0,1,1,1,1},
             {1,1,1,1,0,0,1,1,1,1},
             {1,1,1,1,0,0,1,1,1,1},
             {1,1,1,1,0,0,1,1,1,1},
             {1,1,1,1,0,0,1,1,1,1}
           }

levels[3] = {
             {1,0,1,0,1,0,1,0,1,0},
             {0,1,0,1,0,1,0,1,0,1},
             {1,0,1,0,1,0,1,0,1,0},
             {0,1,0,1,0,1,0,1,0,1},
             {1,0,1,0,1,0,1,0,1,0},
             {0,1,0,1,0,1,0,1,0,1},
             {1,0,1,0,1,0,1,0,1,0},
             {0,1,0,1,0,1,0,1,0,1},
             {1,0,1,0,1,0,1,0,1,0},
             {0,1,0,1,0,1,0,1,0,1},
             {1,0,1,0,1,0,1,0,1,0},
             {0,1,0,1,0,1,0,1,0,1},
             {1,0,1,0,1,0,1,0,1,0},
             {0,1,0,1,0,1,0,1,0,1},
             {1,0,1,0,1,0,1,0,1,0},
             {0,1,0,1,0,1,0,1,0,1},
             {1,0,1,0,1,0,1,0,1,0},
             {0,1,0,1,0,1,0,1,0,1},
             {1,0,1,0,1,0,1,0,1,0},
             {0,1,0,1,0,1,0,1,0,1},
             {1,0,1,0,1,0,1,0,1,0},
             {0,1,0,1,0,1,0,1,0,1},
             {1,0,1,0,1,0,1,0,1,0},
             {0,1,0,1,0,1,0,1,0,1}
           }

-- functions
local addMenuScreen = {}
local betweenMenuScreen = {}
local hideAbout = {}
local removeAbout = {}
local addGameScreen = {}
local buildLevel = {}
local movePaddle = {}
local gameListeners = {}
local startGame = {}
local update = {}
local bounce = {}
local removeBrick = {}
local alert = {}
local restart = {}
local changeLevel = {}


local function Main()
  addMenuScreen()
end

function addMenuScreen()
  menuScreen = display.newGroup()
  menuScreanBackground = display.newImage('mScreen.png')
  startButton = display.newImage('startB.png')
  startButton.name = 'startButton'
  aboutButton = display.newImage('aboutB.png')
  aboutButton.name = 'aboutButton'

  menuScreen:insert(menuScreanBackground)
  startButton.x = 160
  startButton.y = 260
  menuScreen:insert(startButton)
  aboutButton.x = 160
  aboutButton.y = 310
  menuScreen:insert(aboutButton)

  startButton:addEventListener('tap', betweenMenuScreen)
  aboutButton:addEventListener('tap', betweenMenuScreen)
end

function betweenMenuScreen:tap(e)
  if(e.target.name == 'startButton') then
    -- start game
    transition.to(menuScreen, {time = 300, y = -menuScreen.height, transition = easing.outExpo, onComplete = addGameScreen})
  else
    -- about screen
    aboutScreen = display.newImage('aboutScreen.png')
    transition.from(aboutScreen, {time = 300, x = menuScreen.contentWidth, transition = easing.outExpo})
    aboutScreen:addEventListener('tap', hideAbout)

    -- hide menu buttons
    startButton.isVisible = false;
    aboutButton.isVisible = false;
  end
end

function hideAbout:tap(e)
  transition.to(aboutScreen, {time = 300, x = aboutScreen.width*2, transition = easing.outExpo, onComplete = removeAbout})
end

function removeAbout()
  aboutScreen:removeSelf()

  -- show menu buttons
  startButton.isVisible = true;
  aboutButton.isVisible = true;
end

function addGameScreen()
  -- destroy menu screen
  menuScreen:removeSelf()
  menuScreen = nil

  -- add game screen
  paddle = display.newImage('paddle.png')
  ball = display.newImage('ball.png')
  leftWall = display.newImage('sideWall.png', true)
  rightWall = display.newImage('sideWall.png', true)
  topWall = display.newImage('topWall.png', true)
  bottomWall = display.newImage('topWall.png', true)

  paddle.x = 160
  paddle.y = 460
  ball.x = 160
  ball.y = 446
  leftWall.x = -leftWall.width
  rightWall.x = display.contentWidth + rightWall.width
  topWall.y = -topWall.height
  bottomWall.y = display.contentHeight + bottomWall.height / 2

  paddle.name = 'paddle'
  ball.name = 'ball'
  bottomWall.name = 'bottom'

  -- build bricks for level
  buildLevel(levels[1])

  scoreText = display.newText('Score:', 5, 2, 'akashi', 14)
  scoreText:setTextColor(254, 0,51)
  scoreNum = display.newText('0', 54, 2, 'akashi', 14)
  scoreNum:setTextColor(254,0,51)

  levelText = display.newText('Level:', 260, 2, 'akashi', 14)
  levelText:setTextColor(254, 0,51)
  levelNum = display.newText('1', 307, 2, 'akashi', 14)
  levelNum:setTextColor(254,0,51)

  background:addEventListener('tap', startGame)
end

-- function movePaddle:accelerometer(e)
-- end

function buildLevel(level)
  local ROWS = table.maxn(level)
  bricks:toFront()

  for i = 1, ROWS do
    for j = 1, COLUMNS do
      if(level[i][j] == 1) then
        local brick = display.newImage('brick.png')
        brick.name = 'brick'
        brick.x = BRICK_WIDTH * j - BRICK_WIDTH / 2
        brick.y = BRICK_HEIGHT * i + Y_BRICK_OFFSET_FROM_TOP
        physics.addBody(brick, 'static', {density = 1, friction = 0, bounce = 1})
        bricks.insert(bricks, brick)
      end
    end
  end
end

function gameListeners(action)
  if(action == 'add') then
    --Runtime:addEventListener('accelerometer', movePaddle)
    --Runtime:addEventListener('enterFrame', update)
    ball:addEventListener('collision', bounce)
    Runtime:addEventListener('touch', dragPaddle)
  else
    --Runtime:removeEventListener('accelerometer', movePaddle)
    ball:removeEventListener('collision', bounce)
    Runtime:removeEventListener('touch', dragPaddle)
    ball:setLinearVelocity(0,0)
  end
end

function dragPaddle(e)
  if(e.phase == 'began') then
    lastX = e.x - paddle.x
  elseif(e.phase == 'moved') then
    paddle.x = e.x - lastX
  end
end

function startGame:tap(e)
  background:removeEventListener('tap', startGame)
  gameListeners('add')

  -- add objects to physics
  physics.addBody(paddle, 'static', {bounce = 1})
  physics.addBody(ball, {density = 1, friction = 1})
  physics.addBody(leftWall, 'static', {bounce = 1})
  physics.addBody(rightWall, 'static', {bounce = 1})
  physics.addBody(topWall, 'static', {bounce = 1})
  physics.addBody(bottomWall, 'static', {bounce = 1})
  ball:setLinearVelocity(ex,eye);
  ball:setLinearVelocity(xVelocity, yVelocity)
  ball.isFixedRotation = true
end

function bounce(e)
  if (e.phase == 'ended') then
    if(e.other.name == 'brick') then
      -- remove brick
      e.other:removeSelf()
      e.other = nil
      bricks.numChildren = bricks.numChildren - 1

      -- add to score
      score = score + 1
      scoreNum.text = score * SCORE_CONST
      scoreNum:setReferencePoint(display.CenterLeftReferencePoint)
      scoreNum.x = 54

      -- if all bricks destroyed
      if(bricks.numChildren < 0) then
        alert('  You Win!', '  Next Level ›')
        gameEvent = 'win'
      end

    elseif (e.other.name == 'paddle') then
      -- Determines location of collision on paddle, and sets velocity in a certain direction

      -- ex. if ball hits the left side on the paddle, ball would go towards the left.
      -- if it collided even further left, there would be a greater y velocity in that direction

      xVelocity, yVelocity = ball:getLinearVelocity()

      local vectorVelocity = math.sqrt((xVelocity ^ 2) + (yVelocity ^ 2))
      local difference = ball.x - paddle.x
      local halfWidht = paddle.width / 2 + ball.width / 2
      local percent = math.abs(difference / halfWidht)

      if (percent < 1) then
        -- if greater. it means it hit the edge of the paddle (side of paddle)

        xVelocity = math.sqrt((vectorVelocity ^ 2) * percent)
        if (difference < 0) then xVelocity = xVelocity * -1 end

        yVelocity = math.sqrt((vectorVelocity ^ 2) * (1 -percent))
        if (ball.y < paddle.y) then yVelocity = yVelocity * -1 end

        ball:setLinearVelocity(xVelocity, yVelocity)

        --Speed up the ball slightly every bounce off paddle
        ball:applyLinearImpulse(0,-.005)
      end

    elseif (e.other.name == 'bottom') then
      --Lose if collision with bottom
      ball:setLinearVelocity(0,0);
      alert('  You Lose', '  Play Again ›') gameEvent = 'lose'
    end
  end
end

function alert(t, m)
  gameListeners('remove')

  alertBg = display.newImage('alertBg.png')
  box = display.newImage('alertBox.png', 90, 202)

  transition.from(box, {time = 300, xScale = 0.5, yScale = 0.5, transition = easing.outExpo})

  titleTF = display.newText(t, 0, 0, 'akashi', 19)
  titleTF:setTextColor(254,0,51)
  titleTF:setReferencePoint(display.CenterReferencePoint)
  titleTF.x = display.contentCenterX
  titleTF.y = display.contentCenterY - 15

  msgTF = display.newText(m, 0, 0, 'akashi', 12)
  msgTF:setTextColor(254,0,51)
  msgTF:setReferencePoint(display.CenterReferencePoint)
  msgTF.x = display.contentCenterX
  msgTF.y = display.contentCenterY + 15

  box:addEventListener('tap', restart)

  alertScreen = display.newGroup()
  alertScreen:insert(alertBg)
  alertScreen:insert(box)
  alertScreen:insert(titleTF)
  alertScreen:insert(msgTF)
end

function restart(e)
  if(gameEvent == 'win' and table.maxn(levels) > currentLevel) then
    currentLevel = currentLevel + 1
    changeLevel(levels[currentLevel])--next level
    levelNum.text = tostring(currentLevel)
  elseif(gameEvent == 'win' and table.maxn(levels) <= currentLevel) then
    box:removeEventListener('tap', restart)
    alertScreen:removeSelf()
    alertScreen = nil
    alert('  Game Over', '  Congratulations!')
    gameEvent = 'finished'
  elseif(gameEvent == 'lose') then
    changeLevel(levels[currentLevel])--same level
  elseif(gameEvent == 'finished') then
    addMenuScreen()

    transition.from(menuScreen, {time = 300, y = -menuScreen.height, transition = easing.outExpo})

    box:removeEventListener('tap', restart)
    alertScreen:removeSelf()
    alertScreen = nil

    currentLevel = 1

    scoreText:removeSelf()
    scoreText = nil
    scoreNum:removeSelf()
    scoreNum = nil
    levelText:removeSelf()
    levelText = nil
    levelNum:removeSelf()
    levelNum = nil
    ball:removeSelf()
    ball = nil
    paddle:removeSelf()
    paddle = nil
    topWall:removeSelf()
    topWall = nil
    leftWall:removeSelf()
    leftWall = nil
    rightWall:removeSelf()
    rightWall = nil
    bottomWall:removeSelf()
    bottomWall = nil

    score = 0
  end
end

function changeLevel(level)
  -- clear bricks
  bricks:removeSelf()
  bricks.numChildren = 0
  bricks = display.newGroup()

  -- remove alert
  box:removeEventListener('tap', restart)
  alertScreen:removeSelf()
  alertScreen = nil

  -- reset ball and paddle location
  ball.x = (display.contentWidth * 0.5) - (ball.width * 0.5)
  ball.y = (paddle.y - paddle.height) - (ball.height * 0.5) -2
  paddle.x = display.contentWidth * 0.5

  -- build bricks for new level
  buildLevel(level)

  -- button to start the game
  background:addEventListener('tap', startGame)
end


Main()
