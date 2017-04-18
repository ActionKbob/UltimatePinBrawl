local _M = {}

function _M.createView( o )
  o = o or {}

  local _w = o.width or display.actualContentWidth
  local _h = o.height or display.actualContentHeight

  local view = display.newContainer( _w, _h )

  local layers = {}

  local function orderLayers()
    local keys = {}
    for k in pairs( layers ) do keys[ #keys + 1 ] = k end
    table.sort( keys )
    for i = #keys, 1, -1 do
      layers[ keys[i] ]:toFront()
    end
  end

  function view.add( obj, l )
    local l = l or 4
    obj.cameraLayer = l

    if( layers[l] == nil ) then
      layers[l] = display.newGroup()
      view:insert( layers[l] )
      orderLayers()
    end

    layers[l]:insert( obj )

  end

  return view
end

return _M
