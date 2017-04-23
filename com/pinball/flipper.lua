local physics = require 'physics'
local enterFrame = require 'com.lib.enterFrame'

local _M = {}

function _M.new( orientation, imageUrl, params )
  params = params or {}
  local o = display.newImage( imageUrl, { x = -15, y = -15 } )
  physics.addBody( o, 'dynamic', { friction = 1, density = 3, bounce = 0 } );

  local anchorCircle = display.newCircle( 0, 0, 24 )
  anchorCircle.isVisible = false

  local function updateAnchor()
    anchorCircle.x, anchorCircle.y = o.contentBounds.xMin, o.y;
  end
  updateAnchor()

  physics.addBody( anchorCircle, 'static', { radius = 24, isSensor = true } )

  local joint = physics.newJoint( 'pivot', o, anchorCircle, anchorCircle.x, anchorCircle.y );
  joint.isLimitEnabled = true
  joint:setRotationLimits( -30, 20 )

  function o.setPosition( x, y )
    o.x, o.y = x, y
    updateAnchor()
  end

  local function onEnterFrame()
    if( o.active ) then o:applyTorque( -45000 )
    else o:applyTorque( 15000 ) end
  end
  enterFrame.addListener( onEnterFrame )

  return o
end

return _M
