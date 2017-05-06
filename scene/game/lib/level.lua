local mapGenerator = require 'scene.game.lib.level.generator'
local launchRoom = require 'scene.game.lib.level.room.launcher'
local normalRoom = require 'scene.game.lib.level.room.normal'
local configurations = require 'scene.game.lib.level.configurations'

local Level = {}

Level.__index = Level

function Level:create( o )
  o = o or {}
  o.maxRooms = o.maxRooms or 9
  local level = display.newGroup()

  if( o.seed ) then math.randomseed( o.seed ) end

  level.map = mapGenerator:create( o )
  level.roomObjects = {}

  for i = 1, #level.map.rooms do
    local rData = level.map.rooms[i]
    rData.config = configurations:getRandomConfig( rData.type, rData.orientation )
    local newRoom
    if( rData.type == 'L' ) then
      newRoom = launchRoom:create( rData, o.roomWidth, o.roomHeight )
      level.launchRoom = newRoom
    else
      newRoom = normalRoom:create( rData, o.roomWidth, o.roomHeight )
    end
    level.roomObjects[ rData.x * o.maxRooms + rData.y ] = newRoom
    level:insert( newRoom )
  end
  level.currentRoom = level.roomObjects[0]

  function level:doInput( event )
    if( self.currentRoom ) then
      if( event.x <= display.contentCenterX ) then
        self.currentRoom:leftInput( event.phase )
      elseif( event.x > display.contentCenterX ) then
        self.currentRoom:rightInput( event.phase )
      end
    end
  end

  function level:onUpdate()
    if( self.currentRoom ) then
      self.currentRoom:update()
    end

    if( self.trackObject and self.currentRoom ) then
      local tx, ty = self.trackObject.x, self.trackObject.y
      local px, py = math.floor( ( tx + ( o.roomWidth / 2 ) ) / o.roomWidth ), math.floor( ( ty + ( o.roomHeight / 2 ) ) / o.roomHeight )
      if( px ~= self.currentRoom.x or py ~= self.currentRoom.y ) then
        -- TODO: current room on leave
        self.currentRoom = level.roomObjects[ px * o.maxRooms +py ]
      end
    end
  end

  function level:destroy()
    self:removeSelf()
  end

  return level
end

return Level
