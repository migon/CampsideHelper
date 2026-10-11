-- Databáze itemů a jejich buffů
-- Zde můžeš doplňovat přesná ID itemů nebo jejich názvy podle toho, co najdeš např. na Wowheadu.
local function GetAlchemyMana(lvl)
    if lvl < 24 then return 10 elseif lvl < 34 then return 15 elseif lvl < 44 then return 20 elseif lvl < 54 then return 24 else return 29 end
end

local function GetBlacksmithingStr(lvl)
    if lvl < 24 then return 6 elseif lvl < 38 then return 11 elseif lvl < 52 then return 20 else return 34 end
end

local function GetEnchantingText(lvl)
    local armor = 308
    if lvl < 10 then armor = 28 elseif lvl < 20 then armor = 71 elseif lvl < 30 then armor = 114 elseif lvl < 40 then armor = 163 elseif lvl < 50 then armor = 211 elseif lvl < 60 then armor = 260 end
    local stats = 13
    if lvl < 10 then stats = 0 elseif lvl < 20 then stats = 2 elseif lvl < 30 then stats = 4 elseif lvl < 40 then stats = 7 elseif lvl < 50 then stats = 9 elseif lvl < 60 then stats = 12 end
    local resist = 22
    if lvl < 30 then resist = 0 elseif lvl < 40 then resist = 6 elseif lvl < 50 then resist = 12 elseif lvl < 60 then resist = 16 end
    
    local text = "Increases Armor by " .. armor
    if stats > 0 then text = text .. ", all stats by " .. stats end
    if resist > 0 then text = text .. " and all resistances by " .. resist end
    return text
end

local function GetFirstAidStamina(lvl)
    if lvl < 12 then return 3 elseif lvl < 24 then return 8 elseif lvl < 36 then return 21 elseif lvl < 48 then return 34 elseif lvl < 60 then return 45 else return 56 end
end

local function GetMiningAP(lvl)
    if lvl < 12 then return 12 elseif lvl < 22 then return 20 elseif lvl < 32 then return 32 elseif lvl < 42 then return 49 elseif lvl < 52 then return 67 else return 90 end
end

local function GetHerbalismInt(lvl)
    if lvl < 14 then return 2 elseif lvl < 28 then return 6 elseif lvl < 42 then return 12 elseif lvl < 56 then return 18 else return 25 end
end

local function GetTailoringSpirit(lvl)
    if lvl < 40 then return 14 elseif lvl < 50 then return 19 elseif lvl < 60 then return 27 else return 32 end
end

local CampsideItemBuffs = {
    -- Alchemy (Mana)
    ["Mana Well"] = { desc = function(lvl) return "Restores " .. GetAlchemyMana(lvl) .. " mana (every 5 sec)" end, excl = "Blessing of Wisdom" },
    ["Fermenter"] = { desc = function(lvl) return "Restores " .. GetAlchemyMana(lvl) .. " mana (every 5 sec) + Alchemy station" end, excl = "Blessing of Wisdom" },
    ["Alchemy Laboratory"] = { desc = function(lvl) return "Restores " .. GetAlchemyMana(lvl) .. " mana (every 5 sec) + Adv. Alchemy station" end, excl = "Blessing of Wisdom" },
    
    -- Blacksmithing (Strength)
    ["Sharpening Wheel"] = { desc = function(lvl) return "Increases Strength by " .. GetBlacksmithingStr(lvl) end, excl = "Strength of Earth Totem" },
    ["Anvil"] = { desc = function(lvl) return "Increases Strength by " .. GetBlacksmithingStr(lvl) .. " + Anvil" end, excl = "Strength of Earth Totem" },
    ["Master Forge"] = { desc = function(lvl) return "Increases Strength by " .. GetBlacksmithingStr(lvl) .. " + Forge" end, excl = "Strength of Earth Totem" },
    
    -- Cooking (Static)
    ["Basic Campfire Kit"] = { desc = "Allows placement of 3 campsite objects" },
    ["Journeyman Campfire Kit"] = { desc = "Allows placement of 5 campsite objects" },
    ["Expert Campfire Kit"] = { desc = "Allows placement of 10 campsite objects" },
    ["Cookie's Feast"] = { desc = "Allows placement of 10 campsite objects" },
    ["Iron Oven"] = { desc = "Station for advanced cooking recipes" },

    -- Enchanting (MotW)
    ["Enchanted Lute"] = { desc = function(lvl) return GetEnchantingText(lvl) end, excl = "Mark of the Wild" },
    ["Arcane Salvager"] = { desc = function(lvl) return GetEnchantingText(lvl) end, excl = "Mark of the Wild" },
    ["Arcane Forge"] = { desc = function(lvl) return GetEnchantingText(lvl) end, excl = "Mark of the Wild" },

    -- Engineering (Static)
    ["Reagent Bot"] = { desc = "Summons a Reagent Vendor" },
    ["Repair Bot"] = { desc = "Summons a Repair Vendor" },
    ["Anarchist's Workbench"] = { desc = "Vendor / Repair + Engineering station" },

    -- First Aid (Stamina)
    ["First Aid Kit"] = { desc = function(lvl) return "Increases Stamina by " .. GetFirstAidStamina(lvl) end, excl = "Power Word: Fortitude" },
    ["Toxin Study"] = { desc = function(lvl) return "Increases Stamina by " .. GetFirstAidStamina(lvl) end, excl = "Power Word: Fortitude" },
    ["Plague Doctor's Laboratory"] = { desc = function(lvl) return "Increases Stamina by " .. GetFirstAidStamina(lvl) end, excl = "Power Word: Fortitude" },

    -- Fishing (Static Percentage)
    ["Fish Bowl"] = { desc = "Increases all stats by 8%", excl = "Blessing of Kings" },
    ["Fishing Rack"] = { desc = "Increases all stats by 8%", excl = "Blessing of Kings" },
    ["Fishing Hut"] = { desc = "Increases all stats by 8%", excl = "Blessing of Kings" },

    -- Herbalism (Intellect)
    ["Incense Candle"] = { desc = function(lvl) return "Increases Intellect by " .. GetHerbalismInt(lvl) end, excl = "Arcane Intellect" },
    ["Greenhouse"] = { desc = function(lvl) return "Increases Intellect by " .. GetHerbalismInt(lvl) end, excl = "Arcane Intellect" },
    ["Seed Hybridizer"] = { desc = function(lvl) return "Increases Intellect by " .. GetHerbalismInt(lvl) end, excl = "Arcane Intellect" },

    -- Leatherworking (Static)
    ["Camp Tent"] = { desc = "Restores Rested XP up to 5% of a level" },
    ["Tent"] = { desc = "Restores Rested XP up to 5% of a level" },
    ["Tanning Rack"] = { desc = "Restores Rested XP up to 5% of a level + Leatherworking station" },
    ["Sewing Machine"] = { desc = "Restores Rested XP up to 5% of a level + Tailoring station" },

    -- Mining (Attack Power)
    ["Lodestone"] = { desc = function(lvl) return "Increases melee Attack Power by " .. GetMiningAP(lvl) end, excl = "Blessing of Might" },
    ["Rock Garden"] = { desc = function(lvl) return "Increases melee Attack Power by " .. GetMiningAP(lvl) end, excl = "Blessing of Might" },
    ["Molten Foundry"] = { desc = function(lvl) return "Increases melee Attack Power by " .. GetMiningAP(lvl) end, excl = "Blessing of Might" },

    -- Skinning (Static Percentage)
    ["Camp Chair"] = { desc = "Increases Critical Strike chance by 2%", excl = "Moonkin Aura" },
    ["Chair"] = { desc = "Increases Critical Strike chance by 2%", excl = "Moonkin Aura" },
    ["Field Guide"] = { desc = "Increases Critical Strike chance by 2%", excl = "Moonkin Aura" },
    ["Trapper's Workbench"] = { desc = "Increases Critical Strike chance by 2%", excl = "Moonkin Aura" },

    -- Tailoring (Spirit)
    ["Faction Banner"] = { desc = function(lvl) return "Increases Spirit by " .. GetTailoringSpirit(lvl) end, excl = "Divine Spirit" },
    ["Spinning Wheel"] = { desc = function(lvl) return "Increases Spirit by " .. GetTailoringSpirit(lvl) end, excl = "Divine Spirit" },
    ["Loom"] = { desc = function(lvl) return "Increases Spirit by " .. GetTailoringSpirit(lvl) end, excl = "Divine Spirit" },
}

-- Přidání textu do tooltipu světa (ne do batohu)
local function OnTooltipUpdate(tooltip)
    -- Zjistíme jméno objektu ve světě (zpravidla je na prvním řádku tooltipu)
    local objectName = GameTooltipTextLeft1 and GameTooltipTextLeft1:GetText()
    if not objectName then return end

    -- Ochrana proti Blizzard Secret Values (zabezpečené / chráněné řetězce v novějších klientech)
    if issecretvalue and issecretvalue(objectName) then return end

    -- Pokud už jsme tento objekt zpracovali, hned skončíme (šetří výkon)
    local isProcessed = false
    pcall(function()
        isProcessed = (tooltip.campsideLastProcessed == objectName)
    end)
    if isProcessed then return end

    -- Bezpečné vyhledání v databázi přes pcall (ochrana proti nepovoleným klíčům)
    local ok, data = pcall(function() return CampsideItemBuffs[objectName] end)
    if not ok or not data then return end

    -- Ochrana: zkontrolujeme, zda nejde o předmět v batohu nebo o postavu
    local isUnit = false
    pcall(function() isUnit = (tooltip:GetUnit() ~= nil) end)
    if isUnit then return end

    local hasItem = false
    pcall(function()
        local _, link = tooltip:GetItem()
        hasItem = (link ~= nil)
    end)
    if hasItem then return end

    -- Uložíme si, že jsme tento objekt už upravili
    tooltip.campsideLastProcessed = objectName

    local playerLevel = 1
    pcall(function()
        playerLevel = UnitLevel("player") or 1
    end)

    local descriptionText = type(data.desc) == "function" and data.desc(playerLevel) or data.desc
    
    tooltip:AddLine(" ")
    tooltip:AddLine("Campsite Buff: " .. descriptionText, 0.1, 0.9, 0.1, true)
    if data.excl then
        tooltip:AddLine("Exclusive with: " .. data.excl, 1.0, 0.5, 0.0, true)
    end
    tooltip:Show()
end

-- Objektům ve světě se tooltip někdy jen dynamicky přepíše bez schování/zobrazení okna. OnUpdate to zachytí vždy.
GameTooltip:HookScript("OnUpdate", OnTooltipUpdate)

-- Jakmile tooltip zmizí nebo se začne překreslovat, cache vynulujeme
GameTooltip:HookScript("OnTooltipCleared", function(tooltip)
    tooltip.campsideLastProcessed = nil
end)

-- Událost pro vypsání zprávy při načtení addonu do chatu
local loadFrame = CreateFrame("Frame")
loadFrame:RegisterEvent("PLAYER_LOGIN")
loadFrame:SetScript("OnEvent", function()
    DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99[Campside Helper]|r loaded. Hover over campsite objects for buffs!", 1, 1, 1)
end)
