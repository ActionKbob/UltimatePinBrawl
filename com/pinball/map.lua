local room = require 'com.pinball.map.room'
local door = require 'com.pinball.map.door'

local _M = {}

_M.__index = _M

local directions = {
  N = 0,
  E = 1,
  S = 2,
  W = 3
}

local function directionPosition( d )
  if( d == directions.N ) then return { x = 0, y = 1 }
  elseif( d == directions.E ) then return { x = 1, y = 0 }
  elseif( d == directions.S ) then return { x = 0, y = -1 }
  elseif( d == directions.W ) then return { x = -1, y = 0 }
  end
end

local function adjacentDirection( d )
  if( d == directions.N ) then return directions.S
  elseif( d == directions.E ) then return directions.W
  elseif( d == directions.S ) then return directions.N
  elseif( d == directions.W ) then return directions.E
  end
end

local testConfs = {}
testConfs[1] = { 0, 1 }
testConfs[2] = { 0, 3 }
testConfs[3] = { 0, 1, 3 }

function _M:create( o )
  o = o or {}
  o.seed = o.seed or 0
  o.maxRooms = o.maxRooms or 13

  local map = {}

  function map:generate()
    local roomCount = 0
    local function step ( x, y, fromDir )
      local newRoom
      if( x == 0 and y == 0 ) then
        newRoom = room:create( x, y )
        newRoom.doors[ directions.N ] = door.conditions.NONE
        print("launch room")
      else
        newRoom = room:create( x, y )
        local tConf = math.round( math.random(1, 3) )
        print(tConf)
        local c = testConfs[ tConf ]
        for i = 1, #c do
          newRoom.doors[ c[i] ] = door.conditions.NONE
        end
        print("normal room")
      end

      roomCount = roomCount + 1

      if( roomCount <= o.maxRooms ) then
        for k, v in pairs( newRoom.doors ) do
          if( k ~= fromDir ) then
            local adjDir = adjacentDirection( k )
            local nextPos = directionPosition( adjDir )
            step( x + nextPos.x, y + nextPos.y, adjDir )
          end
        end
      end
    end
    step( 0, 0 )
  end

  return map
end

return _M
