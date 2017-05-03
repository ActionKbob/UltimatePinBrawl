local mapGenerator = require 'scene.game.lib.level.generator'
local room = require 'scene.game.lib.level.room'
local configurations = require 'scene.game.lib.level.configurations'

local Level = {}

Level.__index = Level

function Level:create( o )
  o = o or {}
  local level = display.newGroup()

  if( o.seed ) then math.randomseed( o.seed ) end

  level.map = mapGenerator:create( o )

  for i = 1, #level.map.rooms do
    local rData = level.map.rooms[i]
    -- local newRoom = room:create( rData, o.roomWidth, o.roomHeight )
    -- level:insert( newRoom )
    print(rData.solution)
  end

  return level
end

return Level
