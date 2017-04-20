local composer = require 'composer'
local scene = composer.newScene()
local physics = require 'physics'
local cameraView = require 'com.lib.cameraView'

local table = require 'com.pinball.table'

local sceneGroup

function scene:create( event )
  local sceneGroup = self.view
  physics.start()

  local camera = cameraView.createView()
  camera:translate( display.contentCenterX, display.contentCenterY )

  local newTable = table.create()

  camera.add( newTable )
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
