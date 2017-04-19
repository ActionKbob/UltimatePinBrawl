local _M = {}

function _M.createView( o )
  o = o or {}

  local _w = o.width or display.actualContentWidth
  local _h = o.height or display.actualContentHeight

  local camera = display.newContainer( _w, _h )
  local view = display.newGroup()
  camera:insert( view )

  local layers = {}

  local function orderLayers()
    local keys = {}
    for k in pairs( layers ) do keys[ #keys + 1 ] = k end
    table.sort( keys )
    for i = #keys, 1, -1 do
      layers[ keys[i] ]:toFront()
    end
  end

  function camera.add( obj, l )
    local l = l or 4
    obj.cameraLayer = l
    if( layers[l] == nil ) then
      layers[l] = display.newGroup()
      view:insert( layers[l] )
      orderLayers()
    end
    layers[l]:insert( obj )
  end

  function camera.moveTo( x, y, params )
    local params = params or {}
    local x = -x
    local y = -y
    local time = params.time or 500
    local trans = params.transition or easing.inOutQuad
    transition.to( view, {
      x = x, y = y,
      time = time,
      transition = trans
    } )
  end

  function camera.snapTo( x, y )
    view.x = -x
    view.y = -y
  end

  return camera
end

return _M
