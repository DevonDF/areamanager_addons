--[[
	@name AM_NPCS
	@description Disable NPCs entering an area
	@dependencies None
	@author Devon
]]


// CONFIG AREA //

// If an area is listed here, NPCs listed here will be denied, ALL OTHERS will be allowed in
local AM_NPC_BLACKLIST = {
    ["test1"] = {"npc_monk"},
    // ["area uniquename"] = {npc name, npc name, npc name}
}

// If an area is listed here, ONLY those NPCs listed will be allowed to enter
local AM_NPC_WHITELIST = {
    // ["area uniquename"] = {npc name, npc name, npc name}
    // To completely disallow ANY npc in an area, simply do: ["area uniquename"] = {},
    ["test1"] = {},
    ["area2"] = {},
}


// CODE HERE //

// Creating an AM_NPCS table to avoid looping over ents.GetAll repeatedly, which will cause lag
local AM_NPCS = {}

AreaManager:RegisterHook("OnEntityCreated", "am_getnpcs", function(ent)
    if !IsValid(ent) then return end
    if !ent:IsNPC() then return end
    AM_NPCS[ent:EntIndex()] = ent
end)

AreaManager:RegisterHook("EntityRemoved", "am_removenpcs", function(ent)
    if !IsValid(ent) then return end
    if !ent:IsNPC() then return end
    if AM_NPCS[ent:EntIndex()] ~= nil then
        AM_NPCS[ent:EntIndex()] = nil
    end
end)

AreaManager:RegisterTimer("areaManager_NPCCheck", 1, 0, function()

    for entId,npc in pairs(AM_NPCS) do
        if (npc:GetPos() == npc.areamanager_previouspos) then continue end
        local currentArea = npc.areamanager_area
        if currentArea == nil then currentArea = "none" end
        local newArea = AreaManager:VectorToArea(npc:GetPos())
        if (currentArea == newArea) then npc.areamanager_previouspos = npc:GetPos() continue end
        if newArea == "none" then continue end // Don't care if npc is leaving an area

        // Check if an area is whitelist only
        if AM_NPC_WHITELIST[newArea] ~= nil then
            if !table.HasValue(AM_NPC_WHITELIST[newArea], npc:GetClass()) then
                npc:SetPos(npc.areamanager_previouspos)
            end
        elseif AM_NPC_BLACKLIST[newArea] ~= nil then
            if table.HasValue(AM_NPC_BLACKLIST[newArea], npc:GetClass()) then
                npc:SetPos(npc.areamanager_previouspos)
            end
        end
    end

end)