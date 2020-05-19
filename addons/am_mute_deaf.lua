--[[
    @name AreaManager Mute and deaf module
    @description
        Change behaviour of some areas to disallow speaking, and disallow hearing others
    @author Devon
]]
if (!AreaManager) then return end

local MUTED_AREAS = {
    --[[
        List of areas where users inside are muted (cannot speak)

        Add a new area like:
            ["uniquename"] = true,
    ]]
    ["test1"] = true,
}
local DEAF_AREAS = {
    --[[
        List of areas where users are deaf to people outside the area (cannot hear players outside)

        Add a new area like:
            ["uniquename"] = true,
    ]]
    ["test2"] = true,
}

AreaManager:RegisterHook("PlayerCanHearPlayersVoice", "", function(listener, talker)
    --[[
        Handles mute and deaf areas
        
        This should return false if:
            Talker is in a MUTED area
            Listener is in a DEAF AREA and talker is in a different area than listener
    ]]
    if (!IsValid(listener) || !IsValid(talker)) then return end

    local listenerArea = listener:GetArea()
    local talkerArea = talker:GetArea()
    if (listenerArea == nil || talkerArea == nil) then return end

    if (MUTED_AREAS[talkerArea]) then
        return false // Talker is in a MUTED area
    end

    if (DEAF_AREAS[listenerArea] && listenerArea != talkerArea) then
        return false // Listener is in deaf area and talker in diff area
    end
end)