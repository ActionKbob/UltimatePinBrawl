local walls = require 'scene.game.lib.level.room.walls'
local flipper = require 'scene.game.lib.flipper'

local Room = {}
Room.__index = Room

function Room:create( data, width, height )
  local room = display.newGroup()

  room.orientation = data.orientation
  room.configuration = data.config
  room.gridLoc = { x = data.x, y = data.y }
  room.displayLoc = { x = data.x * width, y = data.y * height }
  room.displaySize = { width = width, height = height }

  room.neighbors = data.neighbors

  --Ref
  room.refRect = display.newRect( room, room.displayLoc.x, room.displayLoc.y, width, height )
  room.refRect:setFillColor( math.random(), math.random(), math.random() )

  room.walls = walls:render( room )

  -- Functions
  function room:update()

  end

  function room:leftInput( phase )

  end

  function room:rightInput( phase )
    
  end

  return room
end

return Room
