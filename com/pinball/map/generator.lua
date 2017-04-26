local tile = require 'com.pinball.tile'

local _M = {}

-- T  : NESW
-- 1  : 0000
-- 2  : 0001
-- 3  : 0011
-- 4  : 0100
-- 5  : 0101
-- 6  : 0110
-- 7  : 0111
-- 8  : 1000
-- 9  : 1001
-- 10 : 1010
-- 11 : 1011
-- 12 : 1100
-- 13 : 1101
-- 14 : 1110
-- 15 : 1111

local availablePathTable = {}
availablePathTable[8] = {
  exits = {
    north = { 3, 6, 7, 10, 11, 14, 15 },
    east = nil,
    south = nil,
    west = nil
  }
}

function _M:create( o )
  o = o or {}
  o.__index = o

  o.width = o.width or 13
  o.height = o.height or 13

  o.maxTiles = o.maxTiles or 13

  o.map = {}

  function o:setTile( x, y, t )
    o.map[ x * o.width + y ] = tile:create( x, y, 30, 30, t )
  end

  function o:getTile( x, y )
    return o.map[ x * o.width + y ]
  end

  -- Initial Tile
  o:setTile(0, 0, { type = 8 } )
  -- First Table
  o:setTile(0, -1, { type = 8 } )

  local function generateFrom( x, y )
    local currentTile = o:getTile( x, y )
    local pTable = availablePathTable[ currentTile.type ]

  end

  generateFrom( 0, -1 )

  return o
end

return _M
