local Configurations = {}

local configurationTypes = {
  testLevel = {
    topComponent = 'test',
    bottomComponent = 'pinball'
  }
}

local configurationMap = {}

-- Launcher Configs
configurationMap['L'] = {}

-- Normal Configs
configurationMap['N'] = {}
configurationMap['N'][1] = {} --  W
configurationMap['N'][2] = {} --  S
configurationMap['N'][3] = {} --  S W
configurationMap['N'][4] = {} --  E
configurationMap['N'][5] = {} --  E W
configurationMap['N'][6] = {} --  E S
configurationMap['N'][7] = {} --  E S W
configurationMap['N'][8] = {} --  N
configurationMap['N'][9] = {} --  N W
configurationMap['N'][10] = {} -- N S
configurationMap['N'][11] = {} -- N S W
configurationMap['N'][12] = {} -- N E
configurationMap['N'][13] = {} -- N E W
configurationMap['N'][14] = {} -- N E S
configurationMap['N'][15] = {} -- N E S W

-- Treasure Configs
configurationMap['T'] = {}

-- Shop Configs
configurationMap['S'] = {}
configurationMap['S'][4] = {} --  E
configurationMap['S'][1] = {} --  W

-- Boss Configs
configurationMap['B'] = {}

function Configurations:getRandomConfig( t, o )
  local c = configurationMap[ t ][ o ] or configurationMap[ t ]
  if( #c > 0 ) then
    c = c[ math.random( 1, #c ) ]
  end
  return c
end

return Configurations
