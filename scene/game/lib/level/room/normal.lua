local room = require 'scene.game.lib.level.room'
local flipper = require 'scene.game.lib.flipper'

local Normal = {}

local flipperOffsets = {
  left = {
    x = -130,
    y = 450
  },
  right = {
    x = 130,
    y = 450
  }
}

function Normal:create( data, width, height )
  local this = room:create( data, width, height )

  this.leftFlipper = flipper:createLeft( this, this.displayLoc.x + flipperOffsets.left.x, this.displayLoc.y + flipperOffsets.left.y )
  this.rightFlipper = flipper:createRight( this, this.displayLoc.x + flipperOffsets.right.x, this.displayLoc.y + flipperOffsets.right.y )

  -- Functions
  function this:update()
    if( self.leftFlipper.active ) then
      self.leftFlipper:applyTorque( self.leftFlipper.upperForce )
    else
      self.leftFlipper:applyTorque( self.leftFlipper.downwardForce )
    end

    if( self.rightFlipper.active ) then
      self.rightFlipper:applyTorque( self.rightFlipper.upperForce )
    else
      self.rightFlipper:applyTorque( self.rightFlipper.downwardForce )
    end
  end

  function this:leftInput( phase )
    if( phase == 'began' ) then self.leftFlipper.active = true
    elseif( phase == 'ended' ) then self.leftFlipper.active = false
    end
  end

  function this:rightInput( phase )
    if( phase == 'began' ) then self.rightFlipper.active = true
    elseif( phase == 'ended' ) then self.rightFlipper.active = false
    end
  end

  return this
end

return Normal
