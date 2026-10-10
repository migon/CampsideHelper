-- Databáze itemů a jejich buffů
-- Zde můžeš doplňovat přesná ID itemů nebo jejich názvy podle toho, co najdeš např. na Wowheadu.
local CampsideItemBuffs = {
    -- Alchemy (Mana)
    ["Mana Well"] = { desc = function(lvl) return "Restores ~" .. math.floor(lvl * 0.25 + 1) .. " mana (every 5 sec)" end, excl = "Blessing of Wisdom" },
    ["Fermenter"] = { desc = function(lvl) return "Restores ~" .. math.floor(lvl * 0.25 + 1) .. " mana (every 5 sec) + Alchemy station" end, excl = "Blessing of Wisdom" },
    ["Alchemy Laboratory"] = { desc = function(lvl) return "Restores ~" .. math.floor(lvl * 0.25 + 1) .. " mana (every 5 sec) + Adv. Alchemy station" end, excl = "Blessing of Wisdom" },
    
    -- Blacksmithing (Strength)
    ["Sharpening Wheel"] = { desc = function(lvl) return "Increases Strength by ~" .. math.floor(lvl / 3) end, excl = "Strength of Earth Totem" },
    ["Anvil"] = { desc = function(lvl) return "Increases Strength by ~" .. math.floor(lvl / 3) .. " + Anvil" end, excl = "Strength of Earth Totem" },
    ["Master Forge"] = { desc = function(lvl) return "Increases Strength by ~" .. math.floor(lvl / 3) .. " + Forge" end, excl = "Strength of Earth Totem" },
    
    -- Cooking (Static)
    ["Basic Campfire Kit"] = { desc = "Allows placement of 3 campsite objects" },
    ["Journeyman Campfire Kit"] = { desc = "Allows placement of 5 campsite objects" },
    ["Expert Campfire Kit"] = { desc = "Allows placement of 10 campsite objects" },
    ["Cookie's Feast"] = { desc = "Allows placement of 10 campsite objects" },

    -- Enchanting (MotW)
    ["Enchanted Lute"] = { desc = function(lvl) return "Increases Armor by ~" .. math.floor(lvl * 1.5 + 5) .. " and all stats by ~" .. math.floor(lvl * 0.15 + 1) end, excl = "Mark of the Wild" },
    ["Arcane Salvager"] = { desc = function(lvl) return "Increases Armor by ~" .. math.floor(lvl * 1.5 + 5) .. " and all stats by ~" .. math.floor(lvl * 0.15 + 1) end, excl = "Mark of the Wild" },
    ["Arcane Forge"] = { desc = function(lvl) return "Increases Armor by ~" .. math.floor(lvl * 1.5 + 5) .. " and all stats by ~" .. math.floor(lvl * 0.15 + 1) end, excl = "Mark of the Wild" },

    -- Engineering (Static)
    ["Reagent Bot"] = { desc = "Summons a Reagent Vendor" },
    ["Repair Bot"] = { desc = "Summons a Repair Vendor" },
    ["Anarchist's Workbench"] = { desc = "Vendor / Repair + Engineering station" },

    -- First Aid (Stamina)
    ["First Aid Kit"] = { desc = function(lvl) return "Increases Stamina by ~" .. math.floor(lvl * 0.45) end, excl = "Power Word: Fortitude" },
    ["Toxin Study"] = { desc = function(lvl) return "Increases Stamina by ~" .. math.floor(lvl * 0.45) end, excl = "Power Word: Fortitude" },
    ["Plague Doctor's Laboratory"] = { desc = function(lvl) return "Increases Stamina by ~" .. math.floor(lvl * 0.45) end, excl = "Power Word: Fortitude" },

    -- Fishing (Static Percentage)
    ["Fish Bowl"] = { desc = "Increases all stats by 8%", excl = "Blessing of Kings" },
    ["Fishing Rack"] = { desc = "Increases all stats by 8%", excl = "Blessing of Kings" },
    ["Fishing Hut"] = { desc = "Increases all stats by 8%", excl = "Blessing of Kings" },

    -- Herbalism (Intellect)
    ["Incense Candle"] = { desc = function(lvl) return "Increases Intellect by ~" .. math.floor(lvl * 0.25 + 1) end, excl = "Arcane Intellect" },
    ["Greenhouse"] = { desc = function(lvl) return "Increases Intellect by ~" .. math.floor(lvl * 0.25 + 1) end, excl = "Arcane Intellect" },
    ["Seed Hybridizer"] = { desc = function(lvl) return "Increases Intellect by ~" .. math.floor(lvl * 0.25 + 1) end, excl = "Arcane Intellect" },

    -- Leatherworking (Static)
    ["Camp Tent"] = { desc = "Restores Rested XP up to 5% of a level" },
    ["Tanning Rack"] = { desc = "Restores Rested XP up to 5% of a level + Leatherworking station" },
    ["Sewing Machine"] = { desc = "Restores Rested XP up to 5% of a level + Tailoring station" },

    -- Mining (Attack Power)
    ["Lodestone"] = { desc = function(lvl) return "Increases melee Attack Power by ~" .. math.floor(lvl * 1.5) end, excl = "Blessing of Might" },
    ["Rock Garden"] = { desc = function(lvl) return "Increases melee Attack Power by ~" .. math.floor(lvl * 1.5) end, excl = "Blessing of Might" },
    ["Molten Foundry"] = { desc = function(lvl) return "Increases melee Attack Power by ~" .. math.floor(lvl * 1.5) end, excl = "Blessing of Might" },

    -- Skinning (Static Percentage)
    ["Camp Chair"] = { desc = "Increases Critical Strike chance by 2%", excl = "Moonkin Aura" },
    ["Field Guide"] = { desc = "Increases Critical Strike chance by 2%", excl = "Moonkin Aura" },
    ["Trapper's Workbench"] = { desc = "Increases Critical Strike chance by 2%", excl = "Moonkin Aura" },

    -- Tailoring (Spirit)
    ["Faction Banner"] = { desc = function(lvl) return "Increases Spirit by ~" .. math.floor(lvl * 0.3) end, excl = "Divine Spirit" },
    ["Spinning Wheel"] = { desc = function(lvl) return "Increases Spirit by ~" .. math.floor(lvl * 0.3) end, excl = "Divine Spirit" },
    ["Loom"] = { desc = function(lvl) return "Increases Spirit by ~" .. math.floor(lvl * 0.3) end, excl = "Divine Spirit" },
}

-- Přidání textu do tooltipu světa (ne do batohu)
local function OnTooltipUpdate(tooltip)
    -- Zjistíme jméno objektu ve světě (zpravidla je na prvním řádku tooltipu)
    local objectName = GameTooltipTextLeft1 and GameTooltipTextLeft1:GetText()
    
    -- Pokud už jsme tento objekt zpracovali, hned skončíme (šetří výkon, OnUpdate běží neustále)
    if tooltip.campsideLastProcessed == objectName then return end

    if objectName then
        local data = CampsideItemBuffs[objectName]
        
        if data then
            -- Ochrana: zkontrolujeme, zda nejde o předmět v batohu nebo o postavu
            local _, link = tooltip:GetItem()
            if link then return end
            if tooltip:GetUnit() then return end
            
            -- Uložíme si, že jsme tento objekt už upravili
            tooltip.campsideLastProcessed = objectName

            local playerLevel = UnitLevel("player") or 1
            local descriptionText = type(data.desc) == "function" and data.desc(playerLevel) or data.desc
            
            tooltip:AddLine(" ")
            tooltip:AddLine("Campsite Buff: " .. descriptionText, 0.1, 0.9, 0.1, true)
            if data.excl then
                tooltip:AddLine("Exclusive with: " .. data.excl, 1.0, 0.5, 0.0, true)
            end
            tooltip:Show()
        end
    end
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
