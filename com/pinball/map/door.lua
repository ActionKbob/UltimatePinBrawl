local _M = {
  conditions = {
    NONE = 'door_condition_none'
  }
}

function _M:create( condition )
  local o = {}
  o.condition = condition or conditions.NONE
  return o
end

return _M
