local composer = require 'composer'
local scene = composer.newScene()
local physics = require 'physics'

-- Libs
local enterFrame = require 'com.lib.enterFrame'
local cameraView = require 'com.lib.cameraView'
local levelFactory = require 'scene.game.lib.level'
local ballFactory = require 'scene.game.lib.ball'

-- Local Components
local camera, inputStage, level, ball

function scene:create( event )
  local sceneGroup = self.view
  local params = event.params or {}

  physics.start()
  physics.setGravity( 0, 30 )
  physics.setDrawMode( 'hybrid' )

  local tableArea = { width = 960, height = 1296 }

  local displayScale = display.actualContentWidth / tableArea.width

  camera = cameraView.createView( { width = display.actualContentWidth, height = tableArea.height * displayScale} )
  camera.anchorY = 0
  camera:translate( display.contentCenterX, 0 )
  camera.setDraggable( true )

  camera.animate( { xScale = displayScale, yScale = displayScale, time = 0 } )

  inputStage = display.newRect( display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
  inputStage:addEventListener( 'touch', onInputTouch )
  inputStage.isVisible = false
  inputStage.isHitTestable = true

  sceneGroup:insert( camera )
  sceneGroup:insert( inputStage )

  level = levelFactory:create( { roomWidth = tableArea.width, roomHeight = tableArea.height } )
  camera.add( level, 10 )

  ball = ballFactory:new()
  camera.add( ball, 1 )

  level.trackObject = ball
  level.launchRoom:addEventListener( 'launch_fire', launchBall )

  -- TODO:  add heros from roster
end

function scene:show( event )
  local phase = event.phase
  if( phase == 'will' ) then

  elseif( phase == 'did' ) then
    enterFrame.add( self )
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

function scene:enterFrame()
  if( level ) then level:onUpdate() end
end


function onInputTouch( event )
  local phase = event.phase
  if( level ) then level:doInput( event ) end
end

function launchBall( event )
  if( ball ) then
    ball.isAwake = true
    ball:applyLinearImpulse( 0, -event.charge )
  end
end

scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )
scene:addEventListener( 'destroy', scene )

return scene
