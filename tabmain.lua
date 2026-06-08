-- ============================================================
-- TAB MAIN MODULE
-- ============================================================
return function(MainTab)
    local Dungeons = {
        {name = "Oathlost Castle", id = "World3"}, {name = "Frozen Valley", id = "World2"}, 
        {name = "Starless Forest", id = "World1"}, {name = "Cave of Crystal", id = "Cave1"}, 
        {name = "Cave of Runes", id = "Cave2"}, {name = "Abandoned Courtyard", id = "Cave3"}, 
        {name = "Dragon's Grave", id = "Season1"}
    }
    local DiffOptions = { 
        {name="Trial (1)", id=1}, {name="Challenge (2)", id=2}, {name="Penitent (3)", id=3}, 
        {name="Torment (4)", id=4}, {name="Inferno (5)", id=5}, {name="Hell 1 (6)", id=6}, 
        {name="Hell 2 (7)", id=7}, {name="Hell 3 (8)", id=8}, {name="Hell 4 (9)", id=9}, {name="Hell 5 (10)", id=10} 
    }

    MainTab:AddLabel("Auto Join Settings", true)
    
    MainTab:AddToggle({
        Title = "Enable Auto Join", 
        Default = getgenv().IronBallsConfig.AutoJoin, 
        Callback = function(val) 
            getgenv().IronBallsConfig.AutoJoin = val 
            if getgenv().SaveConfig then getgenv().SaveConfig() end
        end
    })

    -- Deteksi index dropdown berdasarkan config yang udah kesave
    local getDungeonIndex = function() for i, v in ipairs(Dungeons) do if v.id == getgenv().IronBallsConfig.TargetDungeon then return i end end return 1 end
    
    MainTab:AddDropdown({
        Title = "Target Dungeon:", 
        Values = Dungeons, 
        Default = getDungeonIndex(),
        Callback = function(valId) 
            getgenv().IronBallsConfig.TargetDungeon = valId 
            if getgenv().SaveConfig then getgenv().SaveConfig() end
        end
    })

    local getDiffIndex = function() for i, v in ipairs(DiffOptions) do if v.id == getgenv().IronBallsConfig.TargetDifficulty then return i end end return 1 end

    MainTab:AddDropdown({
        Title = "Difficulty:", 
        Values = DiffOptions, 
        Default = getDiffIndex(),
        Callback = function(valId) 
            getgenv().IronBallsConfig.TargetDifficulty = valId 
            if getgenv().SaveConfig then getgenv().SaveConfig() end
        end
    })

    MainTab:AddLabel("Voting Logic", true)
    
    MainTab:AddToggle({
        Title = "Give Up (2nd death)", 
        Default = getgenv().IronBallsConfig.AutoGiveUp, 
        Callback = function(val) 
            getgenv().IronBallsConfig.AutoGiveUp = val 
            if getgenv().SaveConfig then getgenv().SaveConfig() end
        end
    })

    MainTab:AddToggle({
        Title = "Auto Play Again", 
        Default = getgenv().IronBallsConfig.AutoRetry, 
        Callback = function(val) 
            getgenv().IronBallsConfig.AutoRetry = val 
            if getgenv().SaveConfig then getgenv().SaveConfig() end
        end
    })
end-- ============================================================
-- TAB MAIN MODULE
-- ============================================================
return function(MainTab)
    local Dungeons = {
        {name = "Oathlost Castle", id = "World3"}, {name = "Frozen Valley", id = "World2"}, 
        {name = "Starless Forest", id = "World1"}, {name = "Cave of Crystal", id = "Cave1"}, 
        {name = "Cave of Runes", id = "Cave2"}, {name = "Abandoned Courtyard", id = "Cave3"}, 
        {name = "Dragon's Grave", id = "Season1"}
    }
    local DiffOptions = { 
        {name="Trial (1)", id=1}, {name="Challenge (2)", id=2}, {name="Penitent (3)", id=3}, 
        {name="Torment (4)", id=4}, {name="Inferno (5)", id=5}, {name="Hell 1 (6)", id=6}, 
        {name="Hell 2 (7)", id=7}, {name="Hell 3 (8)", id=8}, {name="Hell 4 (9)", id=9}, {name="Hell 5 (10)", id=10} 
    }

    MainTab:AddLabel("Auto Join Settings", true)
    
    MainTab:AddToggle({
        Title = "Enable Auto Join", 
        Default = getgenv().IronBallsConfig.AutoJoin, 
        Callback = function(val) 
            getgenv().IronBallsConfig.AutoJoin = val 
            if getgenv().SaveConfig then getgenv().SaveConfig() end
        end
    })

    -- Deteksi index dropdown berdasarkan config yang udah kesave
    local getDungeonIndex = function() for i, v in ipairs(Dungeons) do if v.id == getgenv().IronBallsConfig.TargetDungeon then return i end end return 1 end
    
    MainTab:AddDropdown({
        Title = "Target Dungeon:", 
        Values = Dungeons, 
        Default = getDungeonIndex(),
        Callback = function(valId) 
            getgenv().IronBallsConfig.TargetDungeon = valId 
            if getgenv().SaveConfig then getgenv().SaveConfig() end
        end
    })

    local getDiffIndex = function() for i, v in ipairs(DiffOptions) do if v.id == getgenv().IronBallsConfig.TargetDifficulty then return i end end return 1 end

    MainTab:AddDropdown({
        Title = "Difficulty:", 
        Values = DiffOptions, 
        Default = getDiffIndex(),
        Callback = function(valId) 
            getgenv().IronBallsConfig.TargetDifficulty = valId 
            if getgenv().SaveConfig then getgenv().SaveConfig() end
        end
    })

    MainTab:AddLabel("Voting Logic", true)
    
    MainTab:AddToggle({
        Title = "Give Up (2nd death)", 
        Default = getgenv().IronBallsConfig.AutoGiveUp, 
        Callback = function(val) 
            getgenv().IronBallsConfig.AutoGiveUp = val 
            if getgenv().SaveConfig then getgenv().SaveConfig() end
        end
    })

    MainTab:AddToggle({
        Title = "Auto Play Again", 
        Default = getgenv().IronBallsConfig.AutoRetry, 
        Callback = function(val) 
            getgenv().IronBallsConfig.AutoRetry = val 
            if getgenv().SaveConfig then getgenv().SaveConfig() end
        end
    })
end
