local _M = {}

function _M:create( x, y, type )
  local o = {}
  o.x, o.y, o.type = x, y, type
  return o
end

return _M
