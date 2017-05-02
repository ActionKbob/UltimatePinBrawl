local Generator = {}

Generator.__index = Generator

-- Returns Room
-- params
-- (int) x: x position
-- (int) y: y position
function Generator:getRoom( x, y )
  local roomIndex = self.grid[ x * self.maxRooms + y ]
  return self.rooms[ roomIndex ]
end

-- Sets Room
-- params
-- (int) x: x position
-- (int) y: y position
-- (table) options: additional data to be set as properties
function Generator:setRoom( x, y )
  local rData = { x = x, y = y, type = 'N', closed = false }
  table.insert( self.rooms, rData )
  self.grid[ x * self.maxRooms + y ] = #self.rooms
  self.rooms[ #self.rooms ].id =  #self.rooms
  --debug Display
  --display.newRect( display.contentCenterX + (x * 30), display.contentCenterY + (y * 30), 25, 25 )
  return self.rooms[ #self.rooms ]
end

-- Returns random open room
function Generator:selectOpenRoom()
  local selected = false
  while not selected do
    local rngRoom = math.random( 1, #self.rooms )
    if not self.rooms[ rngRoom ].closed then
      selected = rngRoom
    end
  end
  return selected
end

-- Lays out the solution path for the map
-- Solution paths are always open, and never require keys to access
-- params
-- (int) s_x: x position
-- (int) s_y: y position
function Generator:makeSolutionPath( s_x, s_y )
  local solutionLength = math.random(4, 5)
  local prevRoom = self:getRoom( s_x, s_y )
  for i = 1, solutionLength do
    local neighbors = self:getNeighbors( prevRoom.id )
    local nextPos = {}
    if( neighbors.east or neighbors.west or i == solutionLength ) then
      nextPos = { x = prevRoom.x, y = prevRoom.y - 1 } -- Go North
    else
      local nprng = math.random( 1, 5 )
      if( nprng == 1 or nprng == 3 ) then
        nextPos = { x = prevRoom.x + 1, y = prevRoom.y } -- Go East
      elseif( nprng == 2 or nprng == 4 ) then
        nextPos = { x = prevRoom.x - 1, y = prevRoom.y } -- Go West
      else
        nextPos = { x = prevRoom.x, y = prevRoom.y - 1 } -- Go North
      end
    end
    prevRoom = self:setRoom( nextPos.x, nextPos.y )
    prevRoom.solution = true
    if( i == solutionLength ) then
      prevRoom.type = 'B'
      prevRoom.closed = true
    end
  end
end

-- Adds additional randomly places rooms to the solution path
function Generator:makeRandomPaths()
  while #self.rooms < self.maxRooms do
    local room = self.rooms[ self:selectOpenRoom() ]
    local neighbors = self:getNeighbors( room.id )
    local nextPos = {}
    local nextRoom

    local rng = math.random( 1, 7 )
    if( rng == 1 or rng == 3 or rng == 5 ) then
      nextPos = { x = room.x - 1, y = room.y }
    elseif( rng == 2 or rng == 4 or rng == 6 ) then
      nextPos = { x = room.x + 1, y = room.y }
    else
      nextPos = { x = room.x, y = room.y - 1 }
    end

    if( not self.grid[ nextPos.x * self.maxRooms + nextPos.y ] ) then
      nextRoom = self:setRoom( nextPos.x, nextPos.y )
      self:closeSurrounded()
    end
  end
end

-- Returns a table of neighboring rooms
-- params
-- (int) roomIndex: Index of room to check
function Generator:getNeighbors( roomIndex )
  local room = self.rooms[ roomIndex ]
  local neighbors = {}
  local north = self.grid[ room.x * self.maxRooms + (room.y - 1) ]
  local east = self.grid[ (room.x + 1) * self.maxRooms + room.y ]
  local south = self.grid[ room.x * self.maxRooms + (room.y + 1) ]
  local west = self.grid[ (room.x - 1) * self.maxRooms + room.y ]
  local count = 0

  if( room.type ~= 'B' ) then
    if( north ) then
      neighbors.north = north
      count = count + 1
    end

    if( east and self.rooms[ east ].type ~= 'B' ) then
      neighbors.east = east
      count = count + 1
    end

    if( west and self.rooms[ west ].type ~= 'B' ) then
      neighbors.west = west
      count = count + 1
    end
  end

  if( south and self.rooms[ south ].type ~= 'B' ) then
    neighbors.south = south
    count = count + 1
  end
  neighbors.count = count
  return neighbors
end

-- Closes all surrounded rooms
function Generator:closeSurrounded()
  for i = 1, #self.rooms do
    local neighbors = self:getNeighbors( i )
    self.rooms[i].neighbors = neighbors
    if( #neighbors >= 3 and not self.rooms[i].closed ) then
      self.rooms[i].closed = true
    end
  end
end

-- Randomly sets configurations for rooms types
-- Responsible for placing treasure/shop rooms
function Generator:finalConfigurations()
  for i = 1, #self.rooms do
    local room = self.rooms[i]
    room.neighbors = self:getNeighbors(i)

    room.orientation = self:getOrientation( room.neighbors )

    if( self.maxShops > 0 and room.type == 'N' and room.neighbors.count == 1 and ( room.neighbors.east or room.neighbors.west ) ) then
      room.type = 'S'
      room.closed = true
      self.maxShops = self.maxShops - 1
    end

    local trRNG = math.random( 1, 12 )
    if( room.id > self.maxRooms / 2 and self.maxTreasures > 0 and room.type == 'N' and trRNG == 12 ) then
      room.type = 'T'
      self.maxTreasures = self.maxTreasures - 1
    end
  end
end

-- Returns the orientation id for it's given neighbors
-- params
-- (table) neighbors
function Generator:getOrientation( neighbors )
  local orientation = 0
  if( neighbors.north ) then orientation = orientation + 8 end
  if( neighbors.east ) then orientation = orientation + 4 end
  if( neighbors.south ) then orientation = orientation + 2 end
  if( neighbors.west ) then orientation = orientation + 1 end
  print(orientation)
  return orientation
end

-- Creates the map layout
-- params
-- (table) o: layout options
function Generator:create( o )
  o = o or {}
  local layout = {}
  setmetatable( layout, self )
  layout.maxRooms = o.maxRooms or 9
  layout.maxShops = o.maxShops or 1
  layout.maxTreasures = o.maxTreasures or 2

  layout.rooms = {}
  layout.grid = {}

  local launchRoom = layout:setRoom( 0, 0 ) -- Launch Room
  local firstRoom = layout:setRoom( 0, -1 ) -- First Real Room

  launchRoom.type = 'L'
  launchRoom.closed = true

  layout:makeSolutionPath( 0, -1 )
  layout:makeRandomPaths()

  layout:finalConfigurations()

  return layout
end

return Generator
