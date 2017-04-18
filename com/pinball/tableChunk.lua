local _M = {}

local vertices = {

}

function _M.create( o )
  local o = display.newPolygon( 0, 0, vertices )
  return o
end

return _M
