--[[
    @name AreaManager levels addon
    @description
        Change behaviour of areas to disallow players entering based on their level
    @dependencies
        https://steamcommunity.com/sharedfiles/filedetails/?id=1724027214
        DarkRP Leveling System (FIXED) by chesiren
    @author Devon
]]
if (!AreaManager) then return end

local LEVEL_AREA_CONFIG = {
    --[[
        List of areas and their required level to enter

        Add a new area like:
            ["uniquename"] = min_level,
    ]]
    ["test1"] = 20,
}


AreaManager:RegisterHook("PlayerCanEnterArea", "areamanager_levelRequired", function(ply, area)
    --[[
        Handles denying areas by level
        
        This should return false if:
            The player's level is below the minimum level required in configuration
    ]]
    if (!IsValid(ply)) then return end
    if (ply:getLevel() == nil) then return end // Addon not installed??

    min_level = LEVEL_AREA_CONFIG[area.uniquename]
    if (min_level && min_level > ply:getLevel()) then // WHY change the convention of method names :(
        return false // Player's level is below minimum level
    end
end)