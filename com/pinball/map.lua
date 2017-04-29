local room = require 'com.pinball.map.room'
local door = require 'com.pinball.map.door'

local Map = {}

Map.__index = Map

function Map:getRoom( x, y )
  local roomIndex = self.grid[ x * self.maxRooms + y ]
  return self.rooms[ roomIndex ]
end

function Map:setRoom( x, y )
  table.insert( self.rooms, room:create( x, y ) )
  self.grid[ x * self.maxRooms + y ] = #self.rooms
  return self.rooms[ #self.rooms ]
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

function Map:closeRoom( roomIndex )
  self.rooms[ roomIndex ].surrounded = true
end

function Map:getAdjacentCoord( roomIndex )
  local col, row = false, false

  local room = self.rooms[ roomIndex ]

  local forceClose = 0
  while not col and not row and forceClose < 50 do
    local rngAdj = math.random( 1, 8 )
    rngAdj = math.round( rngAdj / 2 )
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
    --print(self.grid[ x * self.maxRooms + y ])
    if not self.grid[ x * self.maxRooms + y ] then
      col = x
      row = y
    end

    forceClose = forceClose + 1
  end

  return col, row
end

function Map:getNeighbors( roomIndex )
  local room = self.rooms[ roomIndex ]
  local neighbors = {}

  local north = self.grid[ room.x * self.maxRooms + (room.y - 1) ]
  if( north ) then
    table.insert( neighbors, north )
  end

  local east = self.grid[ (room.x + 1) * self.maxRooms + room.y ]
  if( east ) then
    table.insert( neighbors, east )
  end

  local south = self.grid[ room.x * self.maxRooms + (room.y + 1) ]
  if( south ) then
    table.insert( neighbors, south )
  end

  local west = self.grid[ (room.x - 1) * self.maxRooms + room.y ]
  if( west ) then
    table.insert( neighbors, west )
  end

  return neighbors
end

function Map:closeSurrounded()
  for i = 1, #self.rooms do
    local neighbors = self:getNeighbors( i )
    if( #neighbors >= 3 and not self.rooms[i].surrounded ) then
      self:closeRoom( i )
    end
  end
end

function Map:create( o )
  o = o or {}
  local map = {}
  setmetatable( map, self )

  map.seed = o.seed or nil
  map.maxRooms = o.maxRooms or 13

  if( map.seed ) then math.randomseed( map.seed ) end

  map.rooms = {}
  map.grid = {}

  local launchRoom = map:setRoom( 0, 0 ) -- Launch Room
  local firstRoom = map:setRoom( 0, -1 ) -- First Real Room
  local secondRoom = map:setRoom( 0, -2 ) -- Second Real Room ( Can be any orientation )

  launchRoom.surrounded = true
  launchRoom.discovered = true
  firstRoom.surrounded = true
  firstRoom.discovered = true

  launchRoom:debugDraw()
  firstRoom:debugDraw()
  secondRoom:debugDraw()

  while #map.rooms <  map.maxRooms do
    local openRoom = map:selectOpenRoom()
    newRoomX, newRoomY = map:getAdjacentCoord( openRoom )
    if( newRoomX ~= false or newRoomY ~= false ) then
      local newRoom = map:setRoom( newRoomX, newRoomY )
      map:closeSurrounded()
      newRoom:debugDraw()
    end
  end

  return map
end

return Map
