local composer = require 'composer'
local scene = composer.newScene()
local physics = require 'physics'
local cameraView = require 'com.lib.cameraView'
local flipper = require 'com.pinball.flipper'
local map = require 'com.pinball.map'

--Components
local leftFlipper
local rightFlipper
local newMap

-- Load Globals
local tableArea = composer.getVariable( 'tableSize' )

local function onTouch( event )
  local phase = event.phase
  -- leftFlipper
  if( event.x <= display.contentCenterX ) then
    if( phase == 'began' or phase == 'moved' ) then leftFlipper.active = true
    else leftFlipper.active = false end
  -- RightFlipper
  elseif( event.x > display.contentCenterX ) then
    if( phase == 'began' or phase == 'moved' ) then
       rightFlipper.active = true
    else rightFlipper.active = false end
  end
end

function scene:create( event )
  local sceneGroup = self.view
  physics.start()

  local displayScale = display.actualContentWidth / tableArea.width

  -- local camera = cameraView.createView( { width = display.actualContentWidth, height = tableArea.height * displayScale} )
  -- camera.anchorY = 0
  -- camera:translate( display.contentCenterX, 0 )
  -- camera.setDraggable( true )

  -- local ball = display.newCircle( -100, -100, 45, 45 )
  -- ball:setFillColor( 1, 0, 0 )
  -- physics.addBody( ball, 'dynamic', { radius = 45, density = 1, bounce = 0.1  } )
  -- camera.add( ball, 1 )
  --
  -- leftFlipper = flipper:create( 'left', { imageUrl = 'scene/game/images/flipper.png', x = -130, y = 400 } )
  -- rightFlipper = flipper:create( 'right', { imageUrl = 'scene/game/images/flipper.png', x = 130, y = 400 } )
  --
  -- camera.add( leftFlipper )
  -- camera.add( rightFlipper )

  newMap = map:create()
  
  --physics.setDrawMode( 'hybrid' )
  --camera.zoom( displayScale )
  --Runtime:addEventListener( 'touch', onTouch )
end

function scene:show( event )
  local phase = event.phase
  if( phase == 'will' ) then

  elseif( phase == 'did' ) then

  end
end

function scene:hide( event )
  local phase = event.phase
  if( phase == 'will' ) then

  elseif( phase == 'did' ) then

  end
end

function scene:destroy( event )

end

scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )
scene:addEventListener( 'destroy', scene )

return scene
