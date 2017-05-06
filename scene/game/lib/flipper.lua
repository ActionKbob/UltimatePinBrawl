local physics = require 'physics'
local enterFrame = require 'com.lib.enterFrame'

local _M = {}

_M.__index = _M

local flipperPhysicsOptions = { density = 3, bounce = 0, friction = 1 }

function makeFlipper( url, x, y )
  local flipper = display.newImage( url, x, y )
  local ops = flipperPhysicsOptions
  ops.outline = graphics.newOutline( 2, url )
  physics.addBody( flipper, 'dynamic', ops )
  return flipper
end

function makePivot( x, y, radius )
  local pivot = display.newCircle( x, y, radius )
  pivot.isVisible = false
  physics.addBody( pivot, 'static', { radius = radius, isSensor = true } )
  return pivot
end

function setJoint( flipper, pivot, max, min )
  local joint = physics.newJoint( 'pivot', flipper, pivot, pivot.x, pivot.y )
    joint.isLimitEnabled = true
    joint:setRotationLimits( min, max )
end

local flipperPhysicsOptions = { density = 3, bounce = 0, friction = 1 }

function _M:createLeft( parent, x, y )
  local flipper = makeFlipper( 'scene/game/images/leftFlipper.png', x, y )
  flipper.pivot = makePivot( flipper.x - ( flipper.width * 0.5 ) + ( flipper.height * 0.5 ), flipper.y, flipper.height * 0.5 )
  setJoint( flipper, flipper.pivot, 30, -20 )

  flipper.upperForce = -35000
  flipper.downwardForce = 15000

  parent:insert( flipper )
  return flipper
end

function _M:createRight( parent, x, y )
  local flipper = makeFlipper( 'scene/game/images/rightFlipper.png', x, y )
  flipper.pivot = makePivot( flipper.x + ( flipper.width * 0.5 ) - ( flipper.height * 0.5 ), flipper.y, flipper.height * 0.5 )
  setJoint( flipper, flipper.pivot, 20, -30 )

  flipper.upperForce = 35000
  flipper.downwardForce = -15000

  parent:insert( flipper )
  return flipper
end

return _M
