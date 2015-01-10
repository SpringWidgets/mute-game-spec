function widget:GetInfo()
    return {
        name      = "Mute Game Spec v1",
        desc      = "Disables sound when you start spectating battle (you can enable with F6)",
        author    = "[teh]decay aka [teh]undertaker aka [DoR]Saruman",
        date      = "10 jan 2015",
        license   = "The BSD License",
        layer     = 0,
        version   = 1,
        enabled   = true  -- loaded by default
    }
end


-- project page on github: https://github.com/SpringWidgets/mute-game-spec

--Changelog
-- v2


local spGetMyPlayerID      = Spring.GetMyPlayerID
local spGetPlayerInfo      = Spring.GetPlayerInfo
local spSendCommands       = Spring.SendCommands

function widget:Initialize()
    local playerID = spGetMyPlayerID()
    local _, _, spec, _, _, _, _, _ = spGetPlayerInfo(playerID)

    if ( spec == true ) then
        spSendCommands("mutesound")
    end

    widgetHandler:RemoveWidget()
end
