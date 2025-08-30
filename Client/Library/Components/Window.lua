-- src/Client/Library/Components/Window.lua
local Window = {}
Window.__index = Window

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

function Window.new(player, options, theme)
    local self = setmetatable({}, Window)
    self.Player = player
    self.Options = options or {}
    self.Theme = theme or {}
    self.Sections = {}

    -- Create ScreenGui + main Frame
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = options.Name or "RayFlexUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")

    local main = Instance.new("Frame")
    main.Name = "MainWindow"
    main.Size = UDim2.new(0, 420, 0, 300)
    main.Position = UDim2.new(0.5, -210, 0.5, -150)
    main.BackgroundColor3 = self.Theme.BackgroundColor or Color3.fromRGB(20,20,20)
    main.Parent = screenGui

    -- Titlebar
    local titleBar = Instance.new("Frame", main)
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1,0,0,32)
    titleBar.BackgroundTransparency = 1

    local titleLabel = Instance.new("TextLabel", titleBar)
    titleLabel.Size = UDim2.new(1,-8,1,0)
    titleLabel.Position = UDim2.new(0,4,0,0)
    titleLabel.Text = options.Title or "RayFlex"
    titleLabel.TextColor3 = Color3.new(1,1,1)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 14

    local closeBtn = Instance.new("TextButton", titleBar)
    closeBtn.Text = "X"
    closeBtn.AnchorPoint = Vector2.new(1,0)
    closeBtn.Position = UDim2.new(1,-4,0,0)
    closeBtn.Size = UDim2.new(0,28,1,0)
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    -- Section container
    local content = Instance.new("Frame", main)
    content.Name = "Content"
    content.Position = UDim2.new(0,0,0,32)
    content.Size = UDim2.new(1,0,1,-32)
    content.BackgroundTransparency = 1

    self._gui = {
        ScreenGui = screenGui,
        Main = main,
        Content = content
    }

    -- Dragging
    local dragging = false
    local dragInput, dragStart, startPos
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    return self
end

function Window:CreateSection(title)
    local section = {}
    section.Title = title or ""
    section.Elements = {}

    local secFrame = Instance.new("Frame", self._gui.Content)
    secFrame.Size = UDim2.new(1, -8, 0, 120) -- örnek
    secFrame.Position = UDim2.new(0,4,0, #self.Sections * 126 + 4)
    secFrame.BackgroundTransparency = 1

    local secLabel = Instance.new("TextLabel", secFrame)
    secLabel.Text = section.Title
    secLabel.Size = UDim2.new(1,0,0,20)
    secLabel.BackgroundTransparency = 1

    function section:Toggle(opts)
        local Tog = Instance.new("TextButton", secFrame)
        Tog.Text = opts.label or "Toggle"
        Tog.Size = UDim2.new(0,150,0,28)
        Tog.MouseButton1Click:Connect(function()
            if opts.callback then opts.callback(not self._state) end
            self._state = not self._state
            Tog.Text = (self._state and "On" or "Off") .. " - " .. (opts.label or "Toggle")
        end)
        table.insert(self.Elements, Tog)
        return Tog
    end

    table.insert(self.Sections, section)
    return section
end

return Window

