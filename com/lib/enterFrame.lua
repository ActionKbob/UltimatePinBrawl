local _M = {}

local listeners = {}

local function onEnterFrame( event )
  for i = 1, 1, #listeners do

  end
end

function _M.addListener( listener )
  table.insert( listeners, listener )

  if( #listeners > 0 ) then Runtime:addEventListener( 'enterFrame', onEnterFrame ) end
end

function _M.removeListener( listener )
  local i = 1
  for k, v in pairs( listeners ) do
    if( v == listener ) then
      table.remove( listeners, i )
      break
    end
    i = i + 1
  end

  if( #listeners <= 0 ) then Runtime:removeEventListener( 'enterFrame', onEnterFrame ) end
end

return _M
