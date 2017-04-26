local generator = require 'com.pinball.map.generator'

local _M = {}

_M.__index = _M

function _M:create( o )
  o = o or {}

  o.layout = generator:create()

  return o
end

return _M
