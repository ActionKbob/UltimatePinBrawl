local composer = require 'composer'
local scene = composer.newScene()

local sceneGroup

local function gotoGameScene( event )
  composer.gotoScene( 'scene.game' )
end

function scene:create( event )
  sceneGroup = self.view

  local gameButton = display.newText( sceneGroup, 'Go', display.contentCenterX, display.contentCenterY, system.nativeFont, 44 )
  gameButton:addEventListener( 'tap', gotoGameScene )
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
