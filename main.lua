-----------------------------------------------------------------------------------------
--
--  Main
--
-----------------------------------------------------------------------------------------

local composer = require 'composer'
display.setStatusBar( display.HiddenStatusBar )

-- GLOBALS
composer.setVariable( 'tableSize', { width = 960, height = 1280 } )
composer.gotoScene( 'scene.mainMenu' )
