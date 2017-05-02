

local _M = {}

function _M.createView( o )
  o = o or {}
  local _w = o.width or display.actualContentWidth
  local _h = o.height or display.actualContentHeight

  local camera = display.newContainer( _w, _h )
  local view = display.newGroup()

  -- camera:insert( display.newRect( 0, 0, camera.width, camera.height ) )
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

  local mark = { x = 0, y = 0 }
  local function onTouch( event )
    if( event.phase == 'began' ) then
        mark.x = view.x
        mark.y = view.y
    elseif( event.phase == 'moved' ) then
        local x = (event.x - event.xStart) + mark.x
        local y = (event.y - event.yStart) + mark.y
        camera.move( x, y )
    end
    return true
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
    local x = x
    local y = y
    local time = params.time or 500
    local trans = params.transition or easing.inOutQuad
    local onComplete = params.onComplete or nil
    transition.to( view, {
      x = x, y = y,
      time = time,
      transition = trans,
      onComplete = onComplete
    } )
  end

  function camera.move( x, y )
    view.x = x
    view.y = y
  end

  function camera.zoomTo( z, params )
    local params = params or {}
    local time = params.time or 500
    local trans = params.transition or easing.inOutQuad
    local onComplete = params.onComplete or nil
    transition.to( view, {
      xScale = z, yScale = z,
      time = time,
      transition = trans,
      onComplete = onComplete
    } )
  end

  function camera.zoom( z )
    view.xScale = z
    view.yScale = z
  end

  function camera.opacityTo( a, params )
    local params = params or {}
    local time = params.time or 500
    local trans = params.transition or easing.inOutQuad
    local onComplete = params.onComplete or nil
    transition.to( view, {
      alpha = a,
      time = time,
      transition = trans,
      onComplete = onComplete
    } )
  end

  function camera.opacity( a )
    view.alpha = a
  end

  function camera.setDraggable( v )
    if( v == true ) then
      camera:addEventListener( 'touch', onTouch )
    end
  end

  return camera
end

return _M
