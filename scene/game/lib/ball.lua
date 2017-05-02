local physics = require 'physics'

local Ball = {}

function Ball:new(o)
  local ballContainer = display.newGroup()
  physics.addBody( ballContainer, 'dynamic', { radius = 45, density = 3, friction = 0.1, bounce = 0 } )

  local ballReference = display.newCircle( ballContainer, 0, 0, 45 )

  ballContainer.isAwake = false
  return ballContainer
end

return Ball
