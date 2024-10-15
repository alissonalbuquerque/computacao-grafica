
-- @local GotoScene : Table
local GotoScene = {

    -- @var only-read EFFECT_FADE : string
    EFFECT_FADE         = "fade",
    -- EFFECT_ = "crossFade",
    -- EFFECT_ = "zoomOutIn",
    -- EFFECT_ = "zoomOutInFade",
    -- EFFECT_ = "zoomInOut",
    -- EFFECT_ = "zoomInOutFade",
    -- EFFECT_ = "flip",
    -- EFFECT_ = "flipFadeOutIn"
    -- EFFECT_ = "zoomOutInRotate"
    -- EFFECT_ = "zoomOutInFadeRotate"
    -- EFFECT_ = "zoomInOutRotate"
    -- EFFECT_ = "zoomInOutFadeRotate"
    -- EFFECT_ = "fromRight"
    -- EFFECT_ = "fromLeft"
    -- EFFECT_ = "fromTop"
    -- EFFECT_ = "fromBottom"
    EFFECT_SLIDE_LEFT   = "slideLeft",
    EFFECT_SLIDE_RIGHT  = "slideRight",
    -- EFFECT_ = "slideDown"
    -- EFFECT_ = "slideUp"

    -- "fromRight" — over current scene
    -- "fromLeft" — over current scene
    -- "fromTop" — over current scene
    -- "fromBottom" — over current scene
    -- "slideLeft" — pushes current scene off
    -- "slideRight" — pushes current scene off
    -- "slideDown" — pushes current scene off
    -- "slideUp" — pushes current scene off
    
}

return GotoScene