local mapGenerator = require 'scene.game.lib.level.generator'
local renderer = require 'scene.game.lib.level.renderer'

local Level = {}

Level.__index = Level

function Level:create( o )
  o = o or {}
  local level = {}
  setmetatable( level, self )

  if( o.seed ) then math.randomseed( o.seed ) end

  level.map = mapGenerator:create( o )

  return level
end

return Level
