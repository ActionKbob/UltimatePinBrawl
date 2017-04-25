local flipper = require 'com.pinball.flipper'

local _M = {}

function _M:create( o )
  o = o or {
    orientation = 1
  }
  local flipper = flipper:create( o )
  return flipper
end

return _M
