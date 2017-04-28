local _M = {
  type = {
    FIRST = 'room_first',
    NORMAL = 'room_normal',
    BOSS = 'room_boss'
  }
}

function _M:create( x, y )
  local o = {}
  o.x, o.y = x, y
  o.doors = {}
  self.surrounded = false

  function o.debugDraw()
    local testRect = display.newRect( display.contentCenterX + x * 60, display.contentCenterY + y * 60, 45, 45 )
  end

  return o
end

return _M
