
local function SafeZone(pos)
    if workspace:FindFirstChild('candyhub-safezone') then
        workspace:FindFirstChild('candyhub-safezone').Anchored = false
        workspace:FindFirstChild('candyhub-safezone').CFrame = pos
        workspace:FindFirstChild('candyhub-safezone').Anchored = true
        workspace:FindFirstChild('candyhub-safezone').Rotation = Vector3.new(0,0,0)
    else
        local part = Instance.new('Part', workspace)
        part.Name = 'candyhub-safezone'
        part.CFrame = pos
        part.Size = Vector3.new(10,2,10)
        part.Transparency=0.8
        part.Anchored = true
        part.Rotation = Vector3.new(0,0,0)
    end
end

local function AntiGamepass(mode)
    mode = mode or 'make'
    if mode == 'make' then
        if not game.Players.LocalPlayer.PlayerGui:FindFirstChild('abg2224') then
            local screengui = Instance.new('ScreenGui',game.Players.LocalPlayer.PlayerGui)
            screengui.Name = 'abg2224'
            local ib = Instance.new('ImageButton',screengui)
            ib.Name = 'AntiBuyGamepass'
            ib.Position = UDim2.new(0.001,0,0.001,0)
            ib.Size = UDim2.new(0.05,0,0.001,0)
            ib.BackgroundColor3 = Color3.fromRGB(1,1,1)
        end
    elseif mode == 'check_true' then
        if game.Players.LocalPlayer.PlayerGui:FindFirstChild('abg2224') then
            game.Players.LocalPlayer.PlayerGui:FindFirstChild('abg2224').Enabled = true
        end 
    elseif mode == 'check_false' then
        if game.Players.LocalPlayer.PlayerGui:FindFirstChild('abg2224') then
            game.Players.LocalPlayer.PlayerGui:FindFirstChild('abg2224').Enabled = false
        end 
    end
end

for i, coreui in game.CoreGui:GetChildren() do
    if coreui.Name == 'zzzhub-ui' then
        coreui:Destroy()
    end
end

-- Load UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/zzxzsss/zxs/refs/heads/main/ui/dummyui"))()

-- Create Main Window
local Window = Library:Window({
    Title = "Xtreme hub - Go Fishing",
    Desc = "by xtreme",
    Icon = 1050599229031,
    Theme = "Dark",
    Config = {
        Keybind = Enum.KeyCode.LeftControl,
        Size = UDim2.new(0, 500, 0, 400)
    },
    CloseUIButton = {
        Enabled = true,
        Text = "zzz hub"
    }
})

_G.candyhub = {
    autocast = false,
    autocatch = false,
    autotarget = false,
    autosell = false,
    autostat = false,
    castmode = 'bypass',
    stats={
        fishingspeed = false,
        strength = false,
        luck = false
    },
    rod = 'Steel Rod',
    bait = 'Apple',
    potion = 'Luck Potion I',
    holdtime = 3,
    freezechar = false,
    autozone = false,
    zone = 'Default Isle',
    sellamount = 50,
    infbait = false,
    sellallwait=2.2,
    buyamount=1,
    asafezone=false,
}

local zones = {
    defaultisle = CFrame.new(942.536377, 127.545708, 254.444763, 0.682717562, -0.203110099, 0.701885343, 1.42572915e-07, 0.960588872, 0.277973056, -0.730682373, -0.189776987, 0.655810952),
    vulcanoisle = CFrame.new(829.335938, 128.694641, 926.749512, -0.606504142, -0.202531084, 0.768852293, -1.31778265e-07, 0.967012167, 0.254730254, -0.795080304, 0.154494852, -0.58649689),
    snowybiome = CFrame.new(2192.81934, 132.483459, 262.021057, -0.948030829, -0.0503469296, 0.314169943, -1.65972523e-07, 0.987401605, 0.158234358, -0.318178505, 0.150011003, -0.936087132),
    deepwaters = CFrame.new(-22.3140888, 129.08902, -1377.86743, -0.915984094, -0.121885143, 0.382252723, 1.22360916e-07, 0.952738822, 0.303790689, -0.40121457, 0.278267473, -0.872693598),
    ancientocean = CFrame.new(797.303894, 125.975601, -2088.22656, -0.988837481, 0.0538982712, -0.138908133, 1.20399534e-07, 0.932280302, 0.361736745, 0.148998305, 0.357698828, -0.921873689),
    highfield = CFrame.new(2061.84692, 127.464203, -2582.05103, -0.853039742, 9.32625088e-09, -0.521845937, -1.0396163e-08, 1, 3.48658276e-08, 0.521845937, 3.51671332e-08, -0.853039742),
    toxiczone = CFrame.new(3417.6167, 126.026093, -1539.51465, 0.881312668, -0.0369323492, 0.471088022, -2.10134374e-07, 0.99694097, 0.07815855, -0.472533524, -0.0688822195, 0.878616691),
    mansionisland = CFrame.new(4058.69507, 125.416229, 428.03006, -0.27912733, -5.05664755e-09, -0.960254073, -1.83806048e-09, 1, -4.73165862e-09, 0.960254073, 4.4426976e-10, -0.27912733),
    christmasvilage = CFrame.new()
}

local spawns = {
    defaultisle = CFrame.new(792.481934, 131.844788, -229.427643, -0.864148915, -0.129839927, 0.48619771, 2.46146698e-07, 0.966142178, 0.258010328, -0.503236175, 0.222959474, -0.834890664),
    vulcanoisle = CFrame.new(214.123398, 131.182297, 914.233154, 0.963826895, -0.0171396192, -0.265977234, -1.84809636e-07, 0.99793011, -0.0643074587, 0.266528904, 0.0619813092, 0.961831927),
    snowybiome = CFrame.new(2328.47339, 135.450272, 345.681366, 0.0490640029, -0.258781493, 0.964689016, -2.381624e-07, 0.965852261, 0.259093553, -0.998795629, -0.0127123957, 0.0473885164),
    deepwaters = CFrame.new(-994.533936, 130.379425, -1565.90393, -0.0783816352, 0.160100803, -0.983983755, 1.61409389e-07, 0.987020433, 0.160594881, 0.996923447, 0.0125875305, -0.0773643032),
    ancientocean = CFrame.new(597.376038, 143.6138, -2927.52539, -0.991514087, -0.0304244701, 0.126389101, 2.31731704e-07, 0.972227693, 0.234037116, -0.129999444, 0.232051119, -0.963977396),
    highfield = CFrame.new(2580.38281, 130.265442, -3445.95239, -0.993647218, -0.0136877885, 0.111704528, 1.65538822e-07, 0.992575824, 0.121627413, -0.112540022, 0.120854758, -0.986270189),
    toxiczone = CFrame.new(4688.34961, 140.951889, -2436.05688, -0.662642479, -0.202632681, 0.721002758, 1.70248995e-07, 0.96270287, 0.27056092, -0.748935878, 0.179285273, -0.637927771),
    mansionisland = CFrame.new(5128.0752, 159.531723, 701.879883, -0.00247889198, -5.67627758e-08, 0.999996901, -5.53703998e-08, 1, 5.66256908e-08, -0.999996901, -5.52298616e-08, -0.00247889198),
    christmasvilage = CFrame.new()
}

local function Lives()
    if game.Players.LocalPlayer.Character then
        if game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart') then
            if game.Players.LocalPlayer.Character:FindFirstChild('Humanoid') then
                if game.Players.LocalPlayer.Character:FindFirstChild('Humanoid').Health >= 1 then
                    return true
                else
                    return false
                end
            else
                return false
            end
        else
            return false
        end
    else
        return false
    end
end

local function cne_Rod()
    local rodname = game:GetService("Players").LocalPlayer.inventory.rodsEquippedName.Value
    if Lives() then
        for i, tool in game.Players.LocalPlayer.Character:GetChildren() do
            if tool.ClassName =='Tool' and tool.Name ~= rodname then
                tool.Parent = game.Players.LocalPlayer.Backpack
            end
        end
        if not game.Players.LocalPlayer.Character:FindFirstChild(rodname) then
            if game.Players.LocalPlayer.Backpack:FindFirstChild(rodname) then
                game.Players.LocalPlayer.Backpack:FindFirstChild(rodname).Parent = game.Players.LocalPlayer.Character
            end
        end
    end
end

_G.isselling = false

local function SellAll(v,x)
    if not _G.isselling then
        x=x or {'default','gold','diamond'}
        local default = false
        local gold = false
        local diamond = false
        for g,y in x do
            if y == 'default' then
                default = true
            elseif y == 'gold' then
                gold = true
            elseif y == 'diamond' then
                diamond = true
            end
        end

        local hhe = 0
        for i, fich in game:GetService("Players").LocalPlayer.inventory.fishes:GetChildren() do
            if fich:GetAttribute('tier') == 'default' and default then
                hhe+=1
            elseif fich:GetAttribute('tier') == 'gold' and gold then
                hhe+=1
            elseif fich:GetAttribute('tier') == 'diamond' and diamond then
                hhe+=1
            end
        end
        if hhe >= v and Lives() then
            _G.isselling = true
            local hut = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            for i = 1,20 do
            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(815.194214, 125.560997, -250.464111, -0.847631931, 0, 0.530584812, 0, 1, 0, -0.530584812, 0, -0.847631931)
            task.wait()
            end
            task.wait(_G.candyhub.sellallwait)
            for i, fish in game:GetService("Players").LocalPlayer.inventory.fishes:GetChildren() do
                if fish:GetAttribute('tier') == 'default' and default then
                    local args = {[1] = fish.Name,[2] = fish:GetAttribute('itemId')}
                    game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("fishing"):WaitForChild("itemSell"):InvokeServer(unpack(args))
                elseif fish:GetAttribute('tier') == 'gold' and gold then
                    local args = {[1] = fish.Name,[2] = fish:GetAttribute('itemId')}
                    game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("fishing"):WaitForChild("itemSell"):InvokeServer(unpack(args))
                elseif fish:GetAttribute('tier') == 'diamond' and diamond then
                    local args = {[1] = fish.Name,[2] = fish:GetAttribute('itemId')}
                    game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("fishing"):WaitForChild("itemSell"):InvokeServer(unpack(args))
                end
            end
            task.wait(2.2)
            for i = 1, 20 do
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = hut + Vector3.new(0,3,0)
                SafeZone(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame-Vector3.new(0,3,0))
                task.wait()
            end
            _G.isselling = false
        end
    end
end

-- Create Tabs
local MainTab = Window:Tab({Title = "Main", Icon = "star"})
local ShopTab = Window:Tab({Title = "Shop", Icon = "shopping-cart"})
local AreaTab = Window:Tab({Title = "Area", Icon = "map"})

-- Main Tab
MainTab:Section({Title = "Auto Farm"})

MainTab:Toggle({
    Title = "Auto Cast",
    Desc = "Automatically cast fishing rod",
    Value = false,
    Callback = function(v)
        _G.candyhub.autocast = v
        while _G.candyhub.autocast and task.wait(1.0) do
            if _G.candyhub.castmode == 'bypass' then
                if Lives() then
                    cne_Rod()
                    if not game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart'):FindFirstChild('fishingRodPower').Enabled then
                        if not game:GetService("Players").LocalPlayer.fishing.general.activeFishing.Value then
                            if not game:GetService("Players").LocalPlayer.fishing.general.activeFighting.Value then
                                local h = game:GetService("Players").LocalPlayer.gui.autofishing.Value
                                game:GetService("Players").LocalPlayer.gui.autofishing.Value = true
                                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, nil, 0)
                                repeat task.wait() until game:GetService("Players").LocalPlayer.fishing.general.activeFishing.Value or game:GetService("Players").LocalPlayer.fishing.general.activeFighting.Value
                                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, nil, 0)
                                game:GetService("Players").LocalPlayer.gui.autofishing.Value = h
                            end
                        end
                    end
                end
            elseif _G.candyhub.castmode == 'normal' then
                if Lives() then
                    cne_Rod()
                    if not game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart'):FindFirstChild('fishingRodPower').Enabled then
                        if not game:GetService("Players").LocalPlayer.fishing.general.activeFishing.Value then
                            if not game:GetService("Players").LocalPlayer.fishing.general.activeFighting.Value then
                                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, nil, 0)
                                task.wait(1.3)
                                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, nil, 0)
                            end
                        end
                    end
                end
            end
        end
    end
})

MainTab:Toggle({
    Title = "Auto Catch",
    Desc = "Automatically catch fish",
    Value = false,
    Callback = function(v)
        _G.candyhub.autocatch = v
        while _G.candyhub.autocatch and task.wait() do
            if game:GetService("Players").LocalPlayer.fishing.general.activeFighting.Value then
                game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("fishing"):WaitForChild("fightClick"):FireServer()
            end
        end
    end
})

MainTab:Toggle({
    Title = "Auto Target",
    Desc = "Automatically target fish",
    Value = false,
    Callback = function(v)
        _G.candyhub.autotarget = v
        while _G.candyhub.autotarget and task.wait() do
            local targetFrame = game:GetService('Players').LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("fishing"):WaitForChild("targetFrame")
            AntiGamepass('make')
            for _, target in ipairs(targetFrame:GetChildren()) do
                AntiGamepass('check_true')
                if target:IsA("GuiObject") and _G.candyhub.autotarget and target.Name == 'target' and target:FindFirstChild('ImageButton') then
                    game:GetService('GuiService').SelectedObject = target:FindFirstChild('ImageButton')
                    task.wait()
                    if game:GetService('GuiService').SelectedObject == target:FindFirstChild('ImageButton') and target.Name == 'target' then
                        game:GetService('VirtualInputManager'):SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                        task.wait()
                        game:GetService('VirtualInputManager'):SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                    end
                    task.wait()
                end
                task.wait(0.08)
            end
            AntiGamepass('make')
            AntiGamepass('check_false')
            game:GetService('GuiService').SelectedObject = nil
        end
    end
})

MainTab:Dropdown({
    Title = "Cast Mode",
    List = {"bypass", "normal"},
    Value = "bypass",
    Callback = function(v)
        _G.candyhub.castmode = v
    end
})

MainTab:Section({Title = "Auto Stats"})

MainTab:Toggle({
    Title = "Auto Skills",
    Desc = "Automatically upgrade skills",
    Value = false,
    Callback = function(v)
        _G.candyhub.autostat = v
        while _G.candyhub.autostat and task.wait(1) do
            if game:GetService("Players").LocalPlayer.realstats.upgradePoints.Value >=1 then
                if _G.candyhub.stats.fishingspeed then
                    game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("fishing"):WaitForChild("canPurchaseUpgrade"):InvokeServer("speedBoost")
                end
            end
            if game:GetService("Players").LocalPlayer.realstats.upgradePoints.Value >=1 then
                if _G.candyhub.stats.strength then
                    game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("fishing"):WaitForChild("canPurchaseUpgrade"):InvokeServer("powerBoost")                
                end
            end
            if game:GetService("Players").LocalPlayer.realstats.upgradePoints.Value >=1 then
                if _G.candyhub.stats.luck then
                    game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("fishing"):WaitForChild("canPurchaseUpgrade"):InvokeServer("luckBoost")                
                end
            end
        end
    end
})

MainTab:Toggle({
    Title = "+ Fishing Speed",
    Value = false,
    Callback = function(v)
        _G.candyhub.stats.fishingspeed = v
    end
})

MainTab:Toggle({
    Title = "+ Strength",
    Value = false,
    Callback = function(v)
        _G.candyhub.stats.strength = v
    end
})

MainTab:Toggle({
    Title = "+ Luck",
    Value = false,
    Callback = function(v)
        _G.candyhub.stats.luck = v
    end
})

MainTab:Section({Title = "Auto Sell"})

MainTab:Toggle({
    Title = "Auto Sell Fish",
    Desc = "Automatically sell fish when inventory is full",
    Value = false,
    Callback = function(v)
        _G.candyhub.autosell = v
        _G.isselling = false
        while _G.candyhub.autosell and task.wait(.2) do
            SellAll(_G.candyhub.sellamount,_G.candyhub.selltiers)
        end
    end
})

MainTab:Slider({
    Title = "Sell When Have Fish",
    Min = 1,
    Max = 350,
    Value = 50,
    Callback = function(v)
        _G.candyhub.sellamount = v
    end
})

MainTab:Section({Title = "Cast Zone"})

MainTab:Toggle({
    Title = "Auto Cast Zone",
    Desc = "Automatically go to fishing zone",
    Value = false,
    Callback = function(v)
        _G.candyhub.autozone = v
        while _G.candyhub.autozone and task.wait() do
            SafeZone(_G.candyhub.zone)
            local hhe = 0
            for i, u in game:GetService("Players").LocalPlayer.inventory.fishes:GetChildren() do
                hhe+=1
            end
            if Lives() and _G.candyhub.sellamount > hhe and _G.candyhub.autosell then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = _G.candyhub.zone + Vector3.new(0,3,0)
                if _G.candyhub.freezechar then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                end
                task.wait(1.5)
            elseif not _G.candyhub.autosell then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = _G.candyhub.zone + Vector3.new(0,3,0)
                if _G.candyhub.freezechar then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                end
                task.wait(1.5)
            end
        end
    end
})

MainTab:Toggle({
    Title = "Always SafeZone",
    Value = false,
    Callback = function(v)
        _G.candyhub.asafezone = v
        while _G.candyhub.asafezone and task.wait() do
            SafeZone(_G.candyhub.zone+Vector3.new(0,-1,0))
        end
    end
})

MainTab:Toggle({
    Title = "Freeze Character",
    Desc = "Prevents character from moving",
    Value = false,
    Callback = function(v)
        _G.candyhub.freezechar = v
        while _G.candyhub.freezechar and task.wait(.05) do
            if Lives() then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = _G.candyhub.freezechar
            end
        end
        if _G.candyhub.freezechar == false then
            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
        end
    end
})

-- Shop Tab
ShopTab:Section({Title = "Buy Items"})

local rods = {'Steel Rod','Gold Rod','Diamond Rod','Amethyst Rod','Angel Rod','Shark Rod',
'Rainbow Rod','Devil Rod','Bone Rod','Dead Rod','Trident Rod','Medusa Rod','Hammer Rod','Spider Rod',
'Thunder Rod','Toxic Rod','Nuke Rod','Light Saber Rod', 'Broken Rod'}

local baits = {'Apple','Carrot','Grapes','Worm','Gummy','Fish Bait','Star','Gold','Magma','Diamond','Rainbow','Galaxy','Hairy','Rocket','Nuke','Blackhole'}

local potions = {
'Luck Potion I','Luck Potion II','Luck Potion III',
'Strength Potion I','Strength Potion II','Strength Potion III',
'Speed Potion I','Speed Potion II','Speed Potion III'
}

ShopTab:Dropdown({
    Title = "Rod",
    List = rods,
    Value = "Steel Rod",
    Callback = function(v)
        _G.candyhub.rod = v
    end
})

ShopTab:Button({
    Title = "Buy Rod",
    Desc = "Purchase selected rod",
    Callback = function()
        for i=1,_G.candyhub.buyamount do
            if not game:GetService("Players").LocalPlayer.inventory.rods:FindFirstChild(_G.candyhub.rod) then
                local args = {[1] = _G.candyhub.rod,[2] = "rods",[3] = "fishingSettings",[4] = "oneTime"}
                game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("fishing"):WaitForChild("canShopPurchase"):InvokeServer(unpack(args))
            end
        end
    end
})

ShopTab:Dropdown({
    Title = "Bait",
    List = baits,
    Value = "Apple",
    Callback = function(v)
        _G.candyhub.bait = v
    end
})

ShopTab:Button({
    Title = "Buy Bait",
    Desc = "Purchase selected bait",
    Callback = function()
        for i=1,_G.candyhub.buyamount do
            local args = {[1] = _G.candyhub.bait,[2] = "baits",[3] = "fishingSettings",[4] = "manyTime"}
            game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("fishing"):WaitForChild("canShopPurchase"):InvokeServer(unpack(args))    
        end
    end
})

ShopTab:Dropdown({
    Title = "Potion",
    List = potions,
    Value = "Luck Potion I",
    Callback = function(v)
        _G.candyhub.potion = v
    end
})

ShopTab:Button({
    Title = "Buy Potion",
    Desc = "Purchase selected potion",
    Callback = function()
        for i=1,_G.candyhub.buyamount do
            local args = {[1] = _G.candyhub.potion,[2] = "potions",[3] = "fishingSettings",[4] = "manyTime"}
            game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("fishing"):WaitForChild("canShopPurchase"):InvokeServer(unpack(args))  
        end  
    end
})

ShopTab:Slider({
    Title = "Buy Amount",
    Min = 1,
    Max = 50,
    Value = 1,
    Callback = function(v)
        _G.candyhub.buyamount = v
    end
})

ShopTab:Button({
    Title = "Redeem Codes",
    Desc = "Automatically redeem all available codes",
    Callback = function()
        for i, code in game:GetService("Players").LocalPlayer.rewards.codes:GetChildren() do
            if not code.Value then
                game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("gui"):WaitForChild("canRedeemCode"):InvokeServer(code.Name)
            end
        end
        Window:Notify({
            Title = "zzz hub",
            Desc = "All codes redeemed!",
            Time = 3
        })
    end
})

ShopTab:Section({Title = "Auto Bait"})

ShopTab:Toggle({
    Title = "Auto Buy Bait on Use",
    Desc = "Automatically buy bait when consumed",
    Value = false,
    Callback = function(v)
        _G.candyhub.autobait = v
        while _G.candyhub.autobait and task.wait() do
            local h = game:GetService("Players").LocalPlayer.inventory.baits:FindFirstChild(_G.candyhub.abait or "Apple").Value
            repeat task.wait(.1) until game:GetService("Players").LocalPlayer.inventory.baits:FindFirstChild(_G.candyhub.abait or "Apple").Value < h or not _G.candyhub.autobait
            if _G.candyhub.autobait then
                local args = {[1] = _G.candyhub.abait or "Apple",[2] = "baits",[3] = "fishingSettings",[4] = "manyTime"}
                game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("fishing"):WaitForChild("canShopPurchase"):InvokeServer(unpack(args))    
            end
            task.wait()
        end
    end
})

-- Area Tab
AreaTab:Section({Title = "Teleport"})

AreaTab:Dropdown({
    Title = "Teleport To Island",
    List = {"Default Isle","Vulcano Isle","Snowy Biome","Deep Waters","Ancient Ocean","High Field", "Toxic Zone","Mansion Island","Christmas Village"},
    Value = "",
    Callback = function(v)
        if Lives() then
            if v == 'Default Isle' then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = spawns.defaultisle + Vector3.new(0,3,0)
            elseif v == 'Vulcano Isle' then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = spawns.vulcanoisle + Vector3.new(0,3,0)
            elseif v == 'Snowy Biome' then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = spawns.snowybiome + Vector3.new(0,3,0)
            elseif v == 'Deep Waters' then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = spawns.deepwaters + Vector3.new(0,3,0)
            elseif v == 'Ancient Ocean' then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = spawns.ancientocean + Vector3.new(0,3,0)
            elseif v == 'High Field' then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = spawns.highfield + Vector3.new(0,3,0)
            elseif v == 'Toxic Zone' then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = spawns.toxiczone + Vector3.new(0,3,0)
            elseif v == 'Mansion Island' then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = spawns.mansionisland + Vector3.new(0,6,0)
            elseif v == 'Christmas Village' then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = spawns.christmasvilage + Vector3.new(0,3,0)
            end
        end
    end
})

AreaTab:Section({Title = "Settings/Zone"})

AreaTab:Dropdown({
    Title = "Teleport To Cast-Zone",
    List = {"Default Isle","Vulcano Isle","Snowy Biome","Deep Waters","Ancient Ocean","High Field", "Toxic Zone","Mansion Island","Christmas Village"},
    Value = "",
    Callback = function(v)
        if Lives() then
            if v == 'Default Isle' then
                _G.candyhub.zone = zones.defaultisle
                SafeZone(zones.defaultisle)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = zones.defaultisle + Vector3.new(0,3,0)
            elseif v == 'Vulcano Isle' then
                _G.candyhub.zone = zones.vulcanoisle
                SafeZone(zones.vulcanoisle)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = zones.vulcanoisle + Vector3.new(0,3,0)
            elseif v == 'Snowy Biome' then
                _G.candyhub.zone = zones.snowybiome
                SafeZone(zones.snowybiome)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = zones.snowybiome + Vector3.new(0,3,0)
            elseif v == 'Deep Waters' then
                _G.candyhub.zone = zones.deepwaters
                SafeZone(zones.deepwaters)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = zones.deepwaters + Vector3.new(0,3,0)
            elseif v == 'Ancient Ocean' then
                _G.candyhub.zone = zones.ancientocean
                SafeZone(zones.ancientocean)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = zones.ancientocean + Vector3.new(0,3,0)
            elseif v == 'High Field' then
                _G.candyhub.zone = zones.highfield
                SafeZone(zones.highfield)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = zones.highfield + Vector3.new(0,3,0)
            elseif v == 'Toxic Zone' then
                _G.candyhub.zone = zones.toxiczone
                SafeZone(zones.toxiczone)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = zones.toxiczone + Vector3.new(0,3,0)
            elseif v == 'Mansion Island' then
                _G.candyhub.zone = zones.mansionisland
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = zones.mansionisland + Vector3.new(0,6,0)
            elseif v == 'Christmas Village' then
                _G.candyhub.zone = zones.christmasvilage
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = zones.christmasvilage + Vector3.new(0,3,0)
            end
        end
    end
})

-- Final Notification
Window:Notify({
    Title = "zzz hub",
    Desc = "Go Fishing script loaded successfully! by ktro",
    Time = 4
})
