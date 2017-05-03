local Room = {}
Room.__index = Room

function Room:create( data, width, height )
  local room = display.newGroup()
  local tempRect = display.newRect( room, data.x * width, data.y * height, width, height )
  return room
end

return Room
