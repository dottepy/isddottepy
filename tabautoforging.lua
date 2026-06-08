-- ============================================================
-- TAB AUTO FORGING MODULE
-- ============================================================
return function(ForgeTab)
    ForgeTab:AddLabel("Forge Mode", true)
    
    local mixTgl
    local cycCounter
    
    mixTgl = ForgeTab:AddToggle({
        Title = "Mix Remaining Ores", 
        Default = getgenv().IronBallsConfig.MixTheRest, 
        Callback = function(val) 
            getgenv().IronBallsConfig.MixTheRest = val 
            if getgenv().SaveConfig then getgenv().SaveConfig() end
        end
    })

    ForgeTab:AddToggle({
        Title = "Mass Forge (All Ores)", 
        Default = getgenv().IronBallsConfig.IsMassForge, 
        Callback = function(val) 
            getgenv().IronBallsConfig.IsMassForge = val 
            if cycCounter then cycCounter.UpdateVisibility(not val) end
            if not val and mixTgl then mixTgl.Set(false) end
            if getgenv().SaveConfig then getgenv().SaveConfig() end
        end
    })

    ForgeTab:AddToggle({
        Title = "I have SKIP FORGE Gamepass", 
        Default = getgenv().IronBallsConfig.HasSkipForge, 
        Callback = function(val) 
            getgenv().IronBallsConfig.HasSkipForge = val 
            if getgenv().SaveConfig then getgenv().SaveConfig() end
        end
    })

    local TypeOptions = {{name = "Weapon", id = "Weapon"}, {name = "Armor", id = "Armor"}}
    local getTypeIndex = function() return getgenv().IronBallsConfig.ForgeType == "Armor" and 2 or 1 end

    ForgeTab:AddDropdown({
        Title = "Target Item Type:", 
        Values = TypeOptions, 
        Default = getTypeIndex(),
        Callback = function(valId) 
            getgenv().IronBallsConfig.ForgeType = valId 
            if getgenv().SaveConfig then getgenv().SaveConfig() end
        end
    })

    ForgeTab:AddNumberCounter({
        Title = "Quantity Ore per Cycle:",
        Min = 3, Max = 22,
        Default = getgenv().IronBallsConfig.ForgeQty,
        Callback = function(val)
            getgenv().IronBallsConfig.ForgeQty = val
            if getgenv().SaveConfig then getgenv().SaveConfig() end
        end
    })

    cycCounter = ForgeTab:AddNumberCounter({
        Title = "Total Cycle:",
        Min = 1, Max = 100,
        Default = getgenv().IronBallsConfig.ForgeCycles,
        Callback = function(val)
            getgenv().IronBallsConfig.ForgeCycles = val
            if getgenv().SaveConfig then getgenv().SaveConfig() end
        end
    })
    -- Hidden otomatis kalau Mass Forge lagi nyala
    cycCounter.UpdateVisibility(not getgenv().IronBallsConfig.IsMassForge)

    ForgeTab:AddLabel("Actions", true)
    
    ForgeTab:AddButton({
        Title = "⚒️ Start Forge",
        Callback = function()
            -- Panggil logic function yang ntar lu host di script utama
            if getgenv().StartNormalForge then getgenv().StartNormalForge() end
        end
    })

    ForgeTab:AddButton({
        Title = "🔥 AUTO DUPE",
        Callback = function()
            -- Panggil logic function auto dupe
            if getgenv().StartAutoDupe then getgenv().StartAutoDupe() end
        end
    })
end
