local physics = require 'physics'
local Walls = {}

Walls.__index = Walls

local assetLoc = 'scene/game/images/'
local wallAssetUrls = {
  horiClosed      = assetLoc .. 'solid_wall_h.png',
  horiOpen        = assetLoc .. 'open_wall_h.png',
  vertiClosed     = assetLoc .. 'solid_wall_v.png',
  vertiOpen       = assetLoc .. 'open_wall_v.png',
}

function Walls:render( room )
  local w = {}

  w.north = { x = room.displayLoc.x, y = room.displayLoc.y - ( room.displaySize.height * 0.5 ) }
  w.north.url = room.neighbors.north and wallAssetUrls.horiOpen or wallAssetUrls.horiClosed

  w.east = { x = room.displayLoc.x + ( room.displaySize.width * 0.5 ), y = room.displayLoc.y }
  w.east.url = room.neighbors.east and wallAssetUrls.vertiOpen or wallAssetUrls.vertiClosed

  w.south = { x = room.displayLoc.x, y = room.displayLoc.y + ( room.displaySize.height * 0.5 ) }
  w.south.url = room.neighbors.south and wallAssetUrls.horiOpen or wallAssetUrls.horiClosed

  w.west = { x = room.displayLoc.x - ( room.displaySize.width * 0.5 ), y = room.displayLoc.y }
  w.west.url = room.neighbors.west and wallAssetUrls.vertiOpen or wallAssetUrls.vertiClosed

  w.north.displayObject = display.newImage( room, w.north.url, w.north.x, w.north.y )
  physics.addBody( w.north.displayObject, 'static', { bounce = 0, density = 10 } )
  w.north.displayObject.anchorY = 0

  w.east.displayObject = display.newImage( room, w.east.url, w.east.x, w.east.y )
  physics.addBody( w.east.displayObject, 'static', { bounce = 0, density = 10 } )
  w.east.displayObject.anchorX = 1

  w.south.displayObject = display.newImage( room, w.south.url, w.south.x, w.south.y )
  physics.addBody( w.south.displayObject, 'static', { bounce = 0, density = 10 } )
  w.south.displayObject.anchorY = 1

  w.west.displayObject = display.newImage( room, w.west.url, w.west.x, w.west.y )
  physics.addBody( w.west.displayObject, 'static', { bounce = 0, density = 10 } )
  w.west.displayObject.anchorX = 0

  return w
end

return Walls
