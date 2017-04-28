local _M = {
  type = {
    FIRST = 'room_first',
    NORMAL = 'room_normal'
  }
}

function _M:create( x, y )
  local o = {}
  o.x, o.y = x, y
  o.doors = {}
  
  local testRect = display.newRect( display.contentCenterX + x * 60, display.contentCenterY + y * 60, 30, 30 )
  testRect:setFillColor( math.random(0, 1), math.random(0, 1), math.random(0, 1) )

  return o
end

return _M
