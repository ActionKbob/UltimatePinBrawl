local Room = {
  types = {
    FIRST = 'room_first',
    NORMAL = 'room_normal',
    BOSS = 'room_boss',
    SHOP = 'room_shop',
    TREASURE = 'room_treasure'
  }
}

Room.__index = Room

function Room:debugDraw()
  local testRect = display.newRect( display.contentCenterX + self.x * 60, display.contentCenterY + self.y * 60, 45, 45 )
  if( self.type == self.types.SHOP ) then
    testRect:setFillColor( 0, 0, 1 )
  elseif( self.type == self.types.BOSS ) then
    testRect:setFillColor( 1, 0, 0 )
  end
end

function Room:create( x, y, options )
  local room = {}
  options = options or {}
  setmetatable( room, self )

  room.x, room.y = x, y
  room.type = options.type or room.types.NORMAL

  room.neighbors = {}
  room.closed = false
  room.discovered = false

  return room
end

return Room
