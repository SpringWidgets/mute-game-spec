function widget:GetInfo()
    return {
        name      = "Mute Game Spec v2",
        desc      = "Disables sound when you start spectating battle (you can enable with F6)",
        author    = "[teh]decay aka [teh]undertaker aka [DoR]Saruman & jetbird",
        date      = "18 apr 2015",
        license   = "The BSD License",
        layer     = 0,
        version   = 2,
        enabled   = true  -- loaded by default
    }
end

-- project page on github: https://github.com/SpringWidgets/mute-game-spec

--Changelog
-- v 1   [teh]decay: initial version
-- v 1.1    jetbird: added automatic unmute detector
-- v 1.2 [teh]decay: swith from FPS based decision to GameProgress based
-- v2    [teh]decay: add variable to control "enable sound when cathed up or not"

local enableSound = false



local spGetMyPlayerID      = Spring.GetMyPlayerID
local spGetPlayerInfo      = Spring.GetPlayerInfo
local spSendCommands       = Spring.SendCommands
local spEcho               = Spring.Echo
local spGetTimer           = Spring.GetTimer
local spDiffTimers         = Spring.DiffTimers
local spGameSpeedFactor    = Spring.GetGameSpeed

local serverFrameNum_G = -1;
local initTimer;
local gameFrame = -1;

function widget:GameProgress(serverFrameNum)
    serverFrameNum_G = serverFrameNum;
end

function widget:GameFrame(myGameFrame)
    gameFrame = myGameFrame
    if serverFrameNum_G >= 0 then
        local frameDistanceToFinish = serverFrameNum_G - myGameFrame

        if frameDistanceToFinish < 1 then
            if enableSound then
                spSendCommands("mutesound")
            end
            widgetHandler:RemoveWidget()
        end
    end
end

-- if game was not fast forwarded 5 seconds - then we are synced
function widget:DrawScreen()
    local currTimer = spGetTimer()

    if spDiffTimers(currTimer, initTimer) >= 8 and gameFrame < 0 then
        if enableSound then
            spSendCommands("mutesound")
        end
        widgetHandler:RemoveWidget()
    end
end


function widget:Initialize()
    local playerID = spGetMyPlayerID()
    local _, _, spec, _, _, _, _, _ = spGetPlayerInfo(playerID)

    initTimer = spGetTimer()

    if ( spec == true ) then
        spSendCommands("mutesound")
    else
        widgetHandler:RemoveWidget()
    end
end
