local _M = {}

_M.__index = _M

local roomType = {
  FIRST = 'room_first',
  NORMAL = 'room_normal'
}

function _M:create( o )
  o = o or {}

  return o
end

return _M
