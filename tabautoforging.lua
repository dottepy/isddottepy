-- ============================================================
-- TAB AUTO FORGING MODULE (EXACT MATCH LAYOUT)
-- ============================================================
return function(ForgeTab)
    ForgeTab:AddSegmentedControl({
        Option1 = "Weapon", Option2 = "Armor",
        Default = getgenv().IronBallsConfig.ForgeType,
        Callback = function(val)
            getgenv().IronBallsConfig.ForgeType = val
            if getgenv().SaveConfig then getgenv().SaveConfig() end
        end
    })

    ForgeTab:AddNumberCounter({
        Title = "Quantity Ore per Cycle:",
        Min = 3, Max = 22, Default = getgenv().IronBallsConfig.ForgeQty,
        Callback = function(val)
            getgenv().IronBallsConfig.ForgeQty = val
            if getgenv().SaveConfig then getgenv().SaveConfig() end
        end
    })

    local cycCounter = ForgeTab:AddNumberCounter({
        Title = "Total Cycle:",
        Min = 1, Max = 100, Default = getgenv().IronBallsConfig.ForgeCycles,
        Callback = function(val)
            getgenv().IronBallsConfig.ForgeCycles = val
            if getgenv().SaveConfig then getgenv().SaveConfig() end
        end
    })

    ForgeTab:AddButton({
        Title = "🔎 Scan Ores",
        Callback = function()
            if getgenv().ScanInventory then getgenv().ScanInventory() end
            if getgenv().RefreshOreList then getgenv().RefreshOreList() end
        end
    })

    ForgeTab:AddSearchRow({
        OnSearch = function(text) getgenv().SearchText = text; if getgenv().RefreshOreList then getgenv().RefreshOreList() end end,
        OnSelectAll = function() for n, _ in pairs(getgenv().InventoryData or {}) do getgenv().IronBallsConfig.KeepList[n] = true end; if getgenv().SaveConfig then getgenv().SaveConfig() end; if getgenv().RefreshOreList then getgenv().RefreshOreList() end end,
        OnDeselectAll = function() for n, _ in pairs(getgenv().InventoryData or {}) do getgenv().IronBallsConfig.KeepList[n] = nil end; if getgenv().SaveConfig then getgenv().SaveConfig() end; if getgenv().RefreshOreList then getgenv().RefreshOreList() end end
    })

    -- Inject Custom Ores Scrolling Frame
    local Create = function(cls, props) local inst = Instance.new(cls); for k, v in pairs(props) do inst[k] = v end return inst end
    local OreScroll = Create("ScrollingFrame", {
        Size = UDim2.new(1, 0, 0, 180), BackgroundColor3 = Color3.fromRGB(18, 18, 18),
        ScrollBarThickness = 3, CanvasSize = UDim2.new(0,0,0,0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Parent = ForgeTab.Container -- Ini yang dapet dari library update terbaru
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = OreScroll}); Create("UIStroke", {Color = Color3.fromRGB(45,45,45), Thickness = 1, Parent = OreScroll})
    Create("UIListLayout", {Padding = UDim.new(0, 4), Parent = OreScroll}); Create("UIPadding", {PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 4), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4), Parent = OreScroll})
    getgenv().OreScrollFrame = OreScroll

    local StatusLbl = Create("TextLabel", {Size = UDim2.new(1, 0, 0, 14), BackgroundTransparency = 1, Text = "Scan required...", Font = Enum.Font.Gotham, TextSize = 10, TextColor3 = Color3.fromRGB(170,100,255), TextXAlignment = Enum.TextXAlignment.Left, RichText = true, Parent = ForgeTab.Container})
    getgenv().OreStatusLabel = StatusLbl

    ForgeTab:AddDualToggle({
        Toggle1 = {Title = "Mix Remaining Ores", Default = getgenv().IronBallsConfig.MixTheRest, Callback = function(val) getgenv().IronBallsConfig.MixTheRest = val; if getgenv().SaveConfig then getgenv().SaveConfig() end end},
        Toggle2 = {Title = "Mass Forge (All)", Default = getgenv().IronBallsConfig.IsMassForge, Callback = function(val) 
            getgenv().IronBallsConfig.IsMassForge = val 
            cycCounter.UpdateVisibility(not val)
            if getgenv().SaveConfig then getgenv().SaveConfig() end 
        end}
    })
    cycCounter.UpdateVisibility(not getgenv().IronBallsConfig.IsMassForge)

    ForgeTab:AddToggle({
        Title = "I do have SKIP FORGE Gamepasses",
        Default = getgenv().IronBallsConfig.HasSkipForge,
        Callback = function(val) getgenv().IronBallsConfig.HasSkipForge = val; if getgenv().SaveConfig then getgenv().SaveConfig() end end
    })

    ForgeTab:AddDualButton({
        Button1 = {Title = "⚒️ Forge", Color = Color3.fromRGB(220, 140, 50), Callback = function() if getgenv().StartNormalForge then getgenv().StartNormalForge() end end},
        Button2 = {Title = "🔥 AUTO DUPE", Color = Color3.fromRGB(200, 50, 50), Callback = function() if getgenv().StartAutoDupe then getgenv().StartAutoDupe() end end}
    })

    -- Logic Rendering Isi Ore Scroll (Sama 100% kayak logika lama lu)
    getgenv().RefreshOreList = function()
        if not getgenv().OreScrollFrame then return end
        for _, v in ipairs(getgenv().OreScrollFrame:GetChildren()) do if v:IsA("Frame") then v:Destroy() end end
        local list, keepN, forgeN = {}, 0, 0
        local st = (getgenv().SearchText or ""):lower()
        for rawName, data in pairs(getgenv().InventoryData or {}) do
            local display = data.displayName or rawName
            if st == "" or display:lower():find(st, 1, true) or rawName:lower():find(st, 1, true) then table.insert(list, { raw = rawName, name = display, qty = data.qty, lv = data.lv }) end
        end
        table.sort(list, function(a,b) return a.lv > b.lv end)

        for _, entry in ipairs(list) do
            local isKept = getgenv().IronBallsConfig.KeepList[entry.raw] == true
            if isKept then keepN += 1 else forgeN += 1 end
            local row = Create("Frame", {Size = UDim2.new(1, 0, 0, 26), BackgroundColor3 = isKept and Color3.fromRGB(30, 60, 40) or Color3.fromRGB(25, 25, 25), Parent = getgenv().OreScrollFrame}); Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = row})
            Create("TextLabel", {Text = entry.name, Font = Enum.Font.GothamBold, TextSize = 10, TextColor3 = isKept and Color3.fromRGB(60, 180, 80) or Color3.fromRGB(255,255,255), Size = UDim2.new(1, -150, 1, 0), Position = UDim2.fromOffset(6, 0), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, Parent = row})
            local lvBox = Create("TextLabel", {Text = entry.lv > 0 and ("Lv."..entry.lv) or "Lv.?", Font = Enum.Font.GothamBold, TextSize = 9, TextColor3 = entry.lv > 0 and Color3.fromRGB(255,255,255) or Color3.fromRGB(170,100,255), BackgroundColor3 = entry.lv > 0 and Color3.fromRGB(45,45,45) or Color3.fromRGB(18,18,18), Size = UDim2.fromOffset(30, 16), Position = UDim2.new(1, -145, 0.5, -8), Parent = row}); Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = lvBox})
            Create("TextLabel", {Text = "Avail: " .. entry.qty, Font = Enum.Font.Gotham, TextSize = 10, TextColor3 = Color3.fromRGB(170,100,255), Size = UDim2.fromOffset(50, 18), Position = UDim2.new(1, -110, 0.5, -9), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Right, Parent = row})
            local tgl = Create("TextButton", {Text = isKept and "KEPT" or "FORGE", Font = Enum.Font.GothamBold, TextSize = 9, TextColor3 = Color3.fromRGB(255,255,255), BackgroundColor3 = isKept and Color3.fromRGB(60, 180, 80) or Color3.fromRGB(200, 50, 50), Size = UDim2.fromOffset(50, 18), Position = UDim2.new(1, -55, 0.5, -9), Parent = row}); Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = tgl})
            tgl.MouseButton1Click:Connect(function() getgenv().IronBallsConfig.KeepList[entry.raw] = not getgenv().IronBallsConfig.KeepList[entry.raw] or nil; if getgenv().SaveConfig then getgenv().SaveConfig() end; getgenv().RefreshOreList() end)
        end
        if getgenv().OreStatusLabel then getgenv().OreStatusLabel.Text = string.format('<font color="#F0F0F0">%d</font> ores | <font color="#3CB450">%d</font> kept | <font color="#FFD700">%d</font> ready', #list, keepN, forgeN) end
    end
end
