-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- Composer Module
local composer = require('composer')

local GotoScene = require('utils.composer.GotoScene')

composer.gotoScene('views.Page2.index', GotoScene.EFFECT_FADE)
