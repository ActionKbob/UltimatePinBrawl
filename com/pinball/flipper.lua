local physics = require 'physics'
local enterFrame = require 'com.lib.enterFrame'

local _M = {}

function _M.create( orientation )
  -- orientation = orientation or 'left'
  -- physics.start()
  --
  -- local g = display.newGroup()
  --
  -- local f = display.newRect( g, 0, 0, 80, 30 )
  -- physics.addBody( f, "dynamic", { friction = 1, density = 3, bounce = 0 } );
  --
  -- local p = display.newCircle( g, f.contentBounds.xMin, f.contentBounds.yMin + 15, 15 )
  -- physics.addBody( p, "static", { radius = 7.5, isSensor = true } );
  --
  -- local j = physics.newJoint( 'pivot', f, p, p.x, p.y )
  -- j.isLimitEnabled = true;
  -- j:setRotationLimits( -30, 20)

  return g
end

return _M
