local _M = {}

function _M:create( x, y, width, height, params )
  local o = {}
  o.x, o.y, o.w, o.h = x, y, width, height
  o.x2, o.y2 = o.x + o.w, o.y + o.h
  for k, v in pairs( params ) do
    o[ k ] = v
  end

  print(y * height)

  local tempRect = display.newRect( display.contentCenterX + (x * width), display.contentCenterY + (y * height), width, height )
  math.randomseed( os.time() )
  tempRect:setFillColor( math.random(0, 1), math.random(0, 1), math.random(0, 1) )

  return o
end

return _M
