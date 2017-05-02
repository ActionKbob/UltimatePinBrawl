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

  if( self.neighbors.north ) then local nRect = display.newRect( (display.contentCenterX + self.x * 60), (display.contentCenterY + self.y * 60) - 30, 15, 15 ) end
  if( self.neighbors.east ) then local nRect = display.newRect( (display.contentCenterX + self.x * 60) + 30, (display.contentCenterY + self.y * 60), 15, 15 ) end
  if( self.neighbors.south ) then local nRect = display.newRect( (display.contentCenterX + self.x * 60), (display.contentCenterY + self.y * 60) + 30, 15, 15 ) end
  if( self.neighbors.west ) then local nRect = display.newRect( (display.contentCenterX + self.x * 60) - 30, (display.contentCenterY + self.y * 60), 15, 15 ) end

  if( self.type == self.types.SHOP ) then
    testRect:setFillColor( .5, .4, 0)
  elseif( self.type == self.types.FIRST ) then
    testRect:setFillColor( 0, .8, 0 )
  elseif( self.type == self.types.BOSS ) then
    testRect:setFillColor( .8, 0, 0 )
  elseif( self.type == self.types.TREASURE ) then
    testRect:setFillColor( 1, .9, 0 )
  end
end

function Room:onEnter()
  print( 'Entering Room ' .. self.x .. ':' .. self.y )
end

function Room:onExit()
  print( 'Exiting Room ' .. self.x .. ':' .. self.y )
end

function Room:create( x, y, options )
  local room = {}
  options = options or {}
  setmetatable( room, self )

  room.x, room.y = x, y
  room.type = options.type or room.types.NORMAL

  room.neighbors = {}
  room.solution = false
  room.closed = false
  room.discovered = false
  room.known = false
  room.locked = false

  return room
end

return Room
