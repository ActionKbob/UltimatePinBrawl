local room = require 'com.pinball.map.room'
local door = require 'com.pinball.map.door'

local Map = {}

Map.__index = Map

function Map:getRoom( x, y )
  local roomIndex = self.grid[ x * self.maxRooms + y ]
  return self.rooms[ roomIndex ]
end

function Map:setRoom( x, y, options )
  table.insert( self.rooms, room:create( x, y, options ) )
  self.grid[ x * self.maxRooms + y ] = #self.rooms
  self.rooms[ #self.rooms ].id =  #self.rooms
  return self.rooms[ #self.rooms ]
end

function Map:selectOpenRoom()
  local selected = false
  while not selected do
    local rngRoom = math.random( 1, #self.rooms )
    if not self.rooms[ rngRoom ].closed then
      selected = rngRoom
    end
  end
  return selected
end

function Map:closeRoom( roomIndex )

  local room = self.rooms[ roomIndex ]
  room.closed = true
end

function Map:getNextRoom( roomIndex )
  local col, row = false, false

  local room = self.rooms[ roomIndex ]
  local neighbors = self:getNeighbors( roomIndex )
  local nextRoom = {}

  for i = 1, #neighbors do
    if( #self.rooms < self.maxRooms - 1 ) then
      if( neighbors[i].south ) then
        local rng = math.random( 1, 7 )
        if( rng == 1 or rng == 3 or rng == 5 ) then
          nextRoom = { x = room.x - 1, y = room.y }
        elseif( rng == 2 or rng == 4 or rng == 6 ) then
          nextRoom = { x = room.x + 1, y = room.y }
        else
          nextRoom = { x = room.x, y = room.y - 1 }
        end
      elseif( neighbors[i].west or neighbors[i].east ) then
        local rng = math.random( 1, 25 )
        if( rng < 25 ) then
          nextRoom = { x = room.x, y = room.y - 1 }
        else
          nextRoom = { x = room.x, y = room.y + 1 }
        end
      end
    else
      nextRoom = { x = room.x, y = room.y - 1 }
    end
  end

  if( not self.grid[ nextRoom.x * self.maxRooms + nextRoom.y ] ) then
    col, row = nextRoom.x, nextRoom.y
  end

  return col, row
end

function Map:getNeighbors( roomIndex )
  local room = self.rooms[ roomIndex ]
  local neighbors = {}

  local north = self.grid[ room.x * self.maxRooms + (room.y - 1) ]
  if( north ) then
    table.insert( neighbors, { north = true, value = north} )
  end

  local east = self.grid[ (room.x + 1) * self.maxRooms + room.y ]
  if( east ) then
    table.insert( neighbors, { east = true, value = east })
  end

  local south = self.grid[ room.x * self.maxRooms + (room.y + 1) ]
  if( south ) then
    table.insert( neighbors, { south = true, value = south} )
  end

  local west = self.grid[ (room.x - 1) * self.maxRooms + room.y ]
  if( west ) then
    table.insert( neighbors, { west = true, value = west })
  end

  return neighbors
end

function Map:closeSurrounded()
  for i = 1, #self.rooms do
    local neighbors = self:getNeighbors( i )
    if( #neighbors >= 3 and not self.rooms[i].closed ) then
      self:closeRoom( i )
    end
  end
end

function Map:configRooms()
  for i = 1, #self.rooms do
    local room = self.rooms[i]
    room.neighbors = self:getNeighbors(i)

    if( i == self.maxRooms ) then
      room.type = room.types.BOSS
    end
  end
end

function Map:debugDraw()
  for i = 1, #self.rooms do
    self.rooms[i]:debugDraw();
  end
end

function Map:create( o )
  o = o or {}
  local map = {}
  setmetatable( map, self )

  map.seed = o.seed or nil
  map.maxRooms = o.maxRooms or 9
  map.openShops = o.openShops or 1

  if( map.seed ) then math.randomseed( map.seed ) end

  map.rooms = {}
  map.grid = {}

  local launchRoom = map:setRoom( 0, 0, { type = room.types.FIRST } ) -- Launch Room
  local firstRoom = map:setRoom( 0, -1 ) -- First Real Room
  local secondRoom = map:setRoom( 0, -2 ) -- Second Real Room ( Can be any orientation )

  launchRoom.closed = true
  launchRoom.discovered = true
  firstRoom.closed = true
  firstRoom.discovered = true

  while #map.rooms <  map.maxRooms do
    local openRoom = map:selectOpenRoom()
    newRoomX, newRoomY = map:getNextRoom( openRoom )
    if( newRoomX ~= false or newRoomY ~= false ) then
      local newRoom = map:setRoom( newRoomX, newRoomY, nextRoomConfig )
      map:closeSurrounded()
    end
  end

  map:configRooms()

  map:debugDraw()

  return map
end

return Map
