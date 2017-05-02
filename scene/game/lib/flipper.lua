local physics = require 'physics'
local enterFrame = require 'com.lib.enterFrame'

local _M = {
  active = false
}

_M.__index = _M

local function loadLeft( flipper, imageOutline )
  physics.addBody( flipper, 'dynamic', { density = 3, bounce = 0, friction = 1 } )

  local pivot = display.newCircle( flipper.x - ( flipper.width * 0.5 ) + ( flipper.height * 0.5 ), flipper.y, flipper.height * 0.5 )
  pivot.isVisible = false
  physics.addBody( pivot, 'static', { radius = flipper.height * 0.5, isSensor = true } )

  local joint = physics.newJoint( 'pivot', flipper, pivot, pivot.x, pivot.y )
  joint.isLimitEnabled = true
  joint:setRotationLimits( -30, 20 )

  flipper.upwardForce = -35000
  flipper.downwardForce = 15000
end

local function loadRight( flipper, imageOutline )
  flipper.xScale = -1
  physics.addBody( flipper, 'dynamic', { density = 3, bounce = 0, friction = 1 } )

  local pivot = display.newCircle( flipper.x + ( flipper.width * 0.5 ) - ( flipper.height * 0.5 ), flipper.y, flipper.height * 0.5 )
  pivot.isVisible = false
  physics.addBody( pivot, 'static', { radius = flipper.height * 0.5, isSensor = true } )

  local joint = physics.newJoint( 'pivot', flipper, pivot, pivot.x, pivot.y )
  joint.isLimitEnabled = true
  joint:setRotationLimits( -20, 30 )

  flipper.upwardForce = 35000
  flipper.downwardForce = -15000
end

function _M:create( orientation, o )
  o = o or {}
  local imageUrl = o.imageUrl or ''

  local x = o.x or 0
  local y = o.y or 0

  local flipper = display.newImage( imageUrl, x, y )
  local imageOutline = graphics.newOutline( 2, imageUrl )

  if( orientation == 'left' ) then loadLeft( flipper, imageOutline )
  elseif( orientation == 'right' ) then loadRight( flipper, imageOutline )
  end

  -- Update
  enterFrame.add(flipper)
  function flipper:enterFrame()
    if( flipper.active == true ) then flipper:applyTorque( flipper.upwardForce )
    else flipper:applyTorque( flipper.downwardForce )
    end
  end

  return flipper
end

return _M
