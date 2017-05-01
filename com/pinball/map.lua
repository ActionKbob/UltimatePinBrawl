local generator = require 'com.pinball.map.generator'
local renderer = require 'com.pinball.map.renderer'

local Map = {}

Map.__index = _Map

function Map:create( o )
  local map = {}
  setmetatable( map, self )

  map.layout = generator:create( o )
  map.render = renderer:render( map.layout )
  return map
end

return Map
