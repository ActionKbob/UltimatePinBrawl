local composer = require 'composer'
local scene = composer.newScene()
local physics = require 'physics'
local cameraView = require 'com.lib.cameraView'

local sceneGroup

function scene:create( event )
  local sceneGroup = self.view
  physics.start()

  local camera = cameraView.createView()
  camera:translate( display.contentCenterX, display.contentCenterY )

  local testC = display.newCircle( 0, 0, 30 )
  physics.addBody( testC, 'dynamic' )

  local testR = display.newRect( 0, 100, 100, 10 )
  physics.addBody( testR, 'static' )

  camera.add( testC, 2 )
  camera.add( testR, 5 )

  camera.moveTo( 100, 100 )

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
