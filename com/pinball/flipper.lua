local physics = require 'physics'
local enterFrame = require 'com.lib.enterFrame'

local _M = {
  active = false
}

_M.__index = _M

local function loadLeft( flipper, imageOutline )

  physics.addBody( flipper, 'dynamic', { outline = imageOutline, density = 3, bounce = 0, friction = 1 } )

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

  flipper.upwardForce = -35000
  flipper.downwardForce = 15000
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

  function o.onEnterFrame()
    if( flipper.active ) then
       flipper:applyTorque( flipper.upwardForce )
    else flipper:applyTorque( flipper.downwardForce ) end
  end
  enterFrame.addListener( o.onEnterFrame )

  return flipper
end

return _M

-- local physics = require 'physics'
-- local enterFrame = require 'com.lib.enterFrame'
--
-- local _M = {}
--
-- function _M.new( orientation, imageUrl, params )
--   params = params or {}
--   local o = display.newImage( imageUrl, { x = -15, y = -15 } )
--   physics.addBody( o, 'dynamic', { friction = 1, density = 3, bounce = 0 } );
--
--   local anchorCircle = display.newCircle( 0, 0, 24 )
--   anchorCircle.isVisible = false
--
--   local function updateAnchor()
--     anchorCircle.x, anchorCircle.y = o.contentBounds.xMin, o.y;
--   end
--   updateAnchor()
--
--   physics.addBody( anchorCircle, 'static', { radius = 24, isSensor = true } )
--
--   local joint = physics.newJoint( 'pivot', o, anchorCircle, anchorCircle.x, anchorCircle.y );
--   joint.isLimitEnabled = true
--   joint:setRotationLimits( -30, 20 )
--
--   function o.setPosition( x, y )
--     o.x, o.y = x, y
--     updateAnchor()
--   end
--
--   local function onEnterFrame()
--     if( o.active ) then o:applyTorque( -45000 )
--     else o:applyTorque( 15000 ) end
--   end
--   enterFrame.addListener( onEnterFrame )
--
--   return o
-- end
--
-- return _M
