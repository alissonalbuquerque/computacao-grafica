
-- @local Dimension : Table
local Dimension = {

    -- @var only-read WIDTH : number
    WIDTH = display.contentWidth,

    -- @var only-read HEIGHT : number
    HEIGHT = display.contentHeight,

    -- -- @var  only-read centerX : number
    centerX = display.contentCenterX,

    -- -- @var  only-read centerY : number
    centerY = display.contentCenterY,

    -- @param qtd_slice : number
    -- @return number
    sliceWidth = function(qtd_slice)
        return display.contentWidth / qtd_slice
    end,

    -- @param qtd_slice : number
    -- @return number
    sliceHeight = function (qtd_slice)
        return display.contentHeight / qtd_slice
    end,

    -- @param qtd_decrement : number
    -- @return number
    decrementWidth = function (qtd_decrement)
        return display.contentWidth - qtd_decrement
    end,

    -- @param qtd_decrement : number
    -- @return number
    decrementHeight = function (qtd_decrement)
        return display.contentHeight - qtd_decrement
    end
}

return Dimension