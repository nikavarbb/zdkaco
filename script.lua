--// Load Luminosity UI
local Luminosity = loadstring(game:HttpGet("https://raw.githubusercontent.com/icuck/GenesisStudioLibraries/main/Elerium%20Interface%20Library.lua"))()

--// Setup Window
local Window = Luminosity.new("Pusku Hub", "Saber GUI")
local MainTab = Window:Tab("Main", 6023426915)
local Folder = MainTab:Folder("Automation", "Auto-farming features")

--// Load Functions from Original Script
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild("Events")

-- Helper Function
local function safeLoop(condition, action)
    coroutine.wrap(function()
        while condition() do
            pcall(action)
            task.wait()
        end
    end)()
end

--// Feature Flags
_G.autoSwing = false
_G.autoSell = false
_G.autoRewards = false
_G.autoDNA = false
_G.autoSaber = false
_G.autoClass = false
_G.autoBoss = false
_G.autoEgg = false
_G.autoEquipBest = false

--// GUI Switches
Folder.Switch("Auto Swing", function(value)
    _G.autoSwing = value
    safeLoop(function() return _G.autoSwing end, function()
        Remote:WaitForChild("Swing"):FireServer()
    end)
end)

Folder.Switch("Auto Sell", function(value)
    _G.autoSell = value
    safeLoop(function() return _G.autoSell end, function()
        Remote:WaitForChild("Sell"):FireServer()
    end)
end)

Folder.Switch("Auto Collect Rewards", function(value)
    _G.autoRewards = value
    safeLoop(function() return _G.autoRewards end, function()
        Remote:WaitForChild("Reward"):FireServer()
    end)
end)

Folder.Switch("Auto Buy DNA", function(value)
    _G.autoDNA = value
    safeLoop(function() return _G.autoDNA end, function()
        Remote:WaitForChild("BuyAll"):FireServer("DNA")
    end)
end)

Folder.Switch("Auto Buy Saber", function(value)
    _G.autoSaber = value
    safeLoop(function() return _G.autoSaber end, function()
        Remote:WaitForChild("BuyAll"):FireServer("Sword")
    end)
end)

Folder.Switch("Auto Buy Class", function(value)
    _G.autoClass = value
    safeLoop(function() return _G.autoClass end, function()
        Remote:WaitForChild("BuyAll"):FireServer("Class")
    end)
end)

Folder.Switch("Auto Kill Boss", function(value)
    _G.autoBoss = value
    safeLoop(function() return _G.autoBoss end, function()
        for _, boss in pairs(workspace:FindFirstChild("BossFolder"):GetChildren()) do
            if boss:FindFirstChild("HumanoidRootPart") then
                Player.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
            end
        end
    end)
end)

Folder.Switch("Auto Open Egg (Starter)", function(value)
    _G.autoEgg = value
    safeLoop(function() return _G.autoEgg end, function()
        Remote:WaitForChild("openEgg"):InvokeServer("Starter Egg", false)
    end)
end)

Folder.Switch("Auto Equip Best Pets", function(value)
    _G.autoEquipBest = value
    safeLoop(function() return _G.autoEquipBest end, function()
        Remote:WaitForChild("Pets"):InvokeServer("EquipBest")
    end)
end)

--// Finish
Window:Toggle(true)
