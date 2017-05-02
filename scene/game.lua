local composer = require 'composer'
local scene = composer.newScene()
local physics = require 'physics'

-- Libs
local enterFrame = require 'com.lib.enterFrame'
local cameraView = require 'com.lib.cameraView'
local level = require 'scene.game.lib.level'
local ball = require 'scene.game.lib.ball'

-- Local Components
local camera
local inputStage


function scene:create( event )
  local sceneGroup = self.view
  local params = event.params or {}

  physics.start()

  local tableArea = { width = 960, height = 1280 }

  local displayScale = display.actualContentWidth / tableArea.width

  camera = cameraView.createView( { width = display.actualContentWidth, height = tableArea.height * displayScale} )
  camera.anchorY = 0
  camera:translate( display.contentCenterX, 0 )

  inputStage = display.newRect( display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
  inputStage:addEventListener( 'touch', onInputTouch )
  inputStage.isVisible = false
  inputStage.isHitTestable = true

  sceneGroup:insert( camera )
  sceneGroup:insert( inputStage )

  l = level:create()

  -- TODO:  instantiate level
  --        add heros from roster
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

function scene:enterFrame()

end


function onInputTouch( event )
  local phase = event.phase
end

scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )
scene:addEventListener( 'destroy', scene )

return scene
