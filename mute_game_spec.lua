function widget:GetInfo()
    return {
        name      = "Mute Game Spec v1.1",
        desc      = "Disables sound when you start spectating battle (you can enable with F6)",
        author    = "[teh]decay aka [teh]undertaker aka [DoR]Saruman & jetbird",
        date      = "18 apr 2015",
        license   = "The BSD License",
        layer     = 0,
        version   = 1.1,
        enabled   = true  -- loaded by default
    }
end


-- project page on github: https://github.com/SpringWidgets/mute-game-spec

--Changelog
-- v 1.1 added automatic unmute detector
-- v 1 initial version


local spGetMyPlayerID      = Spring.GetMyPlayerID
local spGetPlayerInfo      = Spring.GetPlayerInfo
local spSendCommands       = Spring.SendCommands
local spEcho               = Spring.Echo

local frameCounter = 0;

function widget:Update(dt)
	--spEcho(dt);
	if dt < 0.035 then
		frameCounter = frameCounter+1
		if frameCounter > 75 then
			spSendCommands("mutesound")
			widgetHandler:RemoveWidget()
		end
	else
		frameCounter = 0
	end
end

function widget:Initialize()
    local playerID = spGetMyPlayerID()
    local _, _, spec, _, _, _, _, _ = spGetPlayerInfo(playerID)

    if ( spec == true ) then
        spSendCommands("mutesound")
	else
		widgetHandler:RemoveWidget()
    end
end
