local room = require 'scene.game.lib.level.room'

local Launcher = {}

local chargeInc = 30

function Launcher:create( data, width, height )
  local this = room:create( data, width, height )

  this.charge = 0

  -- Functions
  function this:update()
    if( self.charging ) then
      self.charge = ( self.charge < 1000 ) and ( self.charge + chargeInc ) or 1000
    end
  end

  function this:doInput( phase )
    if( phase == 'began' ) then
      self.charging = true
    elseif( phase == 'ended' ) then
      self.charging = false
      if( self.charge > 30 ) then
        print(self.charge)
        self:dispatchEvent( { name="launch_fire", charge = self.charge } )
        self.charge = 0
      end
    end
  end

  function this:leftInput( phase )
    self:doInput( phase )
  end

  function this:rightInput( phase )
    self:doInput( phase )
  end

  return this
end

return Launcher
