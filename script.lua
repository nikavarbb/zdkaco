-- Embedded Hydra UI Library
local UILibrary = {}

function UILibrary:Window(title, icon)
    local screenGui = Instance.new("ScreenGui")
    local mainFrame = Instance.new("Frame")
    mainFrame.Parent = screenGui
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    mainFrame.Size = UDim2.new(0, 300, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
    mainFrame.Active = true
    mainFrame.Draggable = true

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = mainFrame
    titleLabel.Text = title
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    titleLabel.Font = Enum.Font.Gotham
    titleLabel.TextSize = 16

    return { MainUI = mainFrame, ScreenGui = screenGui }
end

function UILibrary:Category(name, icon)
    local categoryFrame = Instance.new("Frame")
    categoryFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    categoryFrame.Size = UDim2.new(1, -10, 0, 40)
    categoryFrame.Position = UDim2.new(0, 5, 0, 35)
    return { Frame = categoryFrame, Button = function(title, icon)
        local button = Instance.new("TextButton")
        button.Parent = categoryFrame
        button.Text = title
        button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        button.Size = UDim2.new(1, 0, 1, 0)
        button.TextColor3 = Color3.fromRGB(150, 150, 150)
        return { Section = function(name, side)
            local sectionFrame = Instance.new("Frame")
            sectionFrame.Parent = categoryFrame
            sectionFrame.BackgroundTransparency = 1
            sectionFrame.Size = UDim2.new(1, -20, 0, 200)
            sectionFrame.Position = UDim2.new(0, 10, 0, 45)
            return sectionFrame
        end }
    end }
end

-- Solar - Saber Simulator GUI
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Initialize the main window
local Window = UILibrary:Window("Solar - Saber Simulator", "rbxassetid://7072706620")
local screenGui = Window.ScreenGui
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Draggable functionality is handled by the Draggable property

-- Create Home tab
local Home = UILibrary:Category("Home", "rbxassetid://7072706745")
local HomeButton = Home:Button("Main", "rbxassetid://7072706745")
local HomeSection = HomeButton:Section("Automation", "Left")

-- Auto Swing Toggle
local autoSwing = false
local toggleFrame = Instance.new("TextButton")
toggleFrame.Parent = HomeSection
toggleFrame.Text = "Auto Swing: Off"
toggleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
toggleFrame.Size = UDim2.new(0, 100, 0, 30)
toggleFrame.MouseButton1Click:Connect(function()
    autoSwing = not autoSwing
    toggleFrame.Text = "Auto Swing: " .. (autoSwing and "On" or "Off")
    if autoSwing then
        spawn(function()
            while autoSwing do
                local args = { [1] = "Swing" }
                game:GetService("ReplicatedStorage").Remotes.SaberEvent:FireServer(unpack(args))
                wait(0.1)
            end
        end)
    end
end)

-- Auto Buy Saber Toggle
local autoBuySaber = false
local buyToggleFrame = Instance.new("TextButton")
buyToggleFrame.Parent = HomeSection
buyToggleFrame.Text = "Auto Buy Saber: Off"
buyToggleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
buyToggleFrame.Size = UDim2.new(0, 100, 0, 30)
buyToggleFrame.Position = UDim2.new(0, 0, 0, 40)
buyToggleFrame.MouseButton1Click:Connect(function()
    autoBuySaber = not autoBuySaber
    buyToggleFrame.Text = "Auto Buy Saber: " .. (autoBuySaber and "On" or "Off")
    if autoBuySaber then
        spawn(function()
            while autoBuySaber do
                local args = { [1] = "PurchaseSaber" }
                game:GetService("ReplicatedStorage").Remotes.ShopEvent:FireServer(unpack(args))
                wait(1)
            end
        end)
    end
end)

-- Create Upgrades tab
local Upgrades = UILibrary:Category("Upgrades", "rbxassetid://7072706790")
local UpgradesButton = Upgrades:Button("Main", "rbxassetid://7072706790")
local UpgradesSection = UpgradesButton:Section("Upgrade Options", "Left")

-- Auto Buy Multiplier Toggle
local autoBuyMultiplier = false
local multToggleFrame = Instance.new("TextButton")
multToggleFrame.Parent = UpgradesSection
multToggleFrame.Text = "Auto Buy Multiplier: Off"
multToggleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
multToggleFrame.Size = UDim2.new(0, 120, 0, 30)
multToggleFrame.MouseButton1Click:Connect(function()
    autoBuyMultiplier = not autoBuyMultiplier
    multToggleFrame.Text = "Auto Buy Multiplier: " .. (autoBuyMultiplier and "On" or "Off")
    if autoBuyMultiplier then
        spawn(function()
            while autoBuyMultiplier do
                local args = { [1] = "PurchaseMultiplier" }
                game:GetService("ReplicatedStorage").Remotes.ShopEvent:FireServer(unpack(args))
                wait(1)
            end
        end)
    end
end)

-- Create Pets tab
local Pets = UILibrary:Category("Pets", "rbxassetid://7072706835")
local PetsButton = Pets:Button("Main", "rbxassetid://7072706835")
local PetsSection = PetsButton:Section("Pet Options", "Left")

-- Auto Hatch Egg Button
local hatchButton = Instance.new("TextButton")
hatchButton.Parent = PetsSection
hatchButton.Text = "Hatch Basic Egg"
hatchButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
hatchButton.Size = UDim2.new(0, 100, 0, 30)
hatchButton.MouseButton1Click:Connect(function()
    local args = { [1] = "Hatch", [2] = "Basic Egg" }
    game:GetService("ReplicatedStorage").Remotes.PetEvent:FireServer(unpack(args))
end)

-- Create Teleports tab
local Teleports = UILibrary:Category("Teleports", "rbxassetid://7072706880")
local TeleportsButton = Teleports:Button("Main", "rbxassetid://7072706880")
local TeleportsSection = TeleportsButton:Section("Teleport Options", "Left")

-- Teleport to Boss Button
local teleportButton = Instance.new("TextButton")
teleportButton.Parent = TeleportsSection
teleportButton.Text = "Teleport to Boss"
teleportButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
teleportButton.Size = UDim2.new(0, 100, 0, 30)
teleportButton.MouseButton1Click:Connect(function()
    local bossPosition = Vector3.new(100, 10, 100)
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(bossPosition)
end)

-- Create Settings tab
local Settings = UILibrary:Category("Settings", "rbxassetid://7072706925")
local SettingsButton = Settings:Button("Main", "rbxassetid://7072706925")
local SettingsSection = SettingsButton:Section("UI Settings", "Left")

-- Toggle UI Visibility Button
local uiToggleButton = Instance.new("TextButton")
uiToggleButton.Parent = SettingsSection
uiToggleButton.Text = "Toggle UI (Shift)"
uiToggleButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
uiToggleButton.Size = UDim2.new(0, 100, 0, 30)
local uiVisible = true
uiToggleButton.MouseButton1Click:Connect(function()
    uiVisible = not uiVisible
    Window.MainUI.Visible = uiVisible
end)
