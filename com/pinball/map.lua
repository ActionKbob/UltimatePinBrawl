local room = require 'com.pinball.map.room'
local door = require 'com.pinball.map.door'

local Map = {}

Map.__index = Map

function Map:getRoom( x, y )
  local roomIndex = self.grid[ x * self.maxRooms + y ]
  return self.rooms[ roomIndex ]
end

function Map:setRoom( x, y )
  print("adding: " .. x .. ":" .. y)
  table.insert( self.rooms, room:create( x, y ) )
  self.grid[ x * self.maxRooms + y ] = #self.rooms

  self.rooms[ #self.rooms ].debugDraw()
end

function Map:selectOpenRoom()
  local selected = false
  while not selected do
    local rngRoom = math.random( 1, #self.rooms )
    if not self.rooms[ rngRoom ].surrounded then
      selected = rngRoom
    end
  end
  return selected
end

function Map:adjacentCoord( roomIndex )
  local col, row = false, false

  local room = self.rooms[ roomIndex ]

  local forceClose = 0
  while not col and not row and forceClose < 24 do
    local rngAdj = math.random( 1, 4 )
    local x, y

    if( rngAdj == 1 ) then
      x, y = room.x, room.y - 1
    elseif( rngAdj == 2 ) then
      x, y = room.x + 1, room.y
    elseif( rngAdj == 3 ) then
      x, y = room.x, room.y + 1
    elseif( rngAdj == 4 ) then
      x, y = room.x - 1, room.y
    end

    if not self.grid[ x * self.maxRooms + y ] then
      col = x
      row = y
    end

    forceClose = forceClose + 1
  end

  return col, row
end

function Map:create( o )
  o = o or {}
  local map = map or {}
  setmetatable( map, self )

  map.seed = o.seed or 0
  map.maxRooms = o.maxRooms or 13

  map.rooms = {}
  map.grid = {}

  map:setRoom( 0, 0 ) -- Launch Room
  map:setRoom( 0, -1 ) -- First Real Room
  map:setRoom( 0, -2 ) -- Second Real Room ( Can be any orientation )

  map:getRoom( 0, 0 ).surrounded = true
  map:getRoom( 0, -1 ).surrounded = true

  for i = 4, map.maxRooms do
    local openRoom = map:selectOpenRoom()

    newRoomX, newRoomY = map:adjacentCoord( openRoom )

    map:setRoom( newRoomX, newRoomY )

  end

  return map
end

return Map
