local Room = {
  type = {
    FIRST = 'room_first',
    NORMAL = 'room_normal',
    BOSS = 'room_boss'
  }
}

Room.__index = Room

function Room:debugDraw()
  local testRect = display.newRect( display.contentCenterX + self.x * 60, display.contentCenterY + self.y * 60, 45, 45 )
  print(self.surrounded)
  if( not self.discovered ) then
    testRect:setFillColor( 0.5, 0.5, 0.5 )
  else
    testRect:setFillColor( 1, 1, 1 )
  end
end

function Room:create( x, y )
  local room = {}
  setmetatable( room, self )

  room.x, room.y = x, y
  room.doors = {}
  room.surrounded = false
  room.discovered = false

  return room
end

return Room
