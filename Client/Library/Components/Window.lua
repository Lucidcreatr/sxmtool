-- Window.lua
local Section = require(script.Parent:WaitForChild("Section"))
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local Window = {}
Window.__index = Window

function Window.new(opts, theme)
    local self = setmetatable({}, Window)
    self.Sections = {}
    self.Theme = theme or {}
    
    -- ScreenGui oluştur
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = opts.Name or "SXMLIBRAR"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- Main Frame
    local main = Instance.new("Frame")
    main.Name = "MainWindow"
    main.Size = UDim2.new(0, 420, 0, 300)
    main.Position = UDim2.new(0.5, -210, 0.5, -150)
    main.BackgroundColor3 = self.Theme.BackgroundColor or Color3.fromRGB(20,20,20)
    main.Parent = screenGui
    
    -- TitleBar
    local titleBar = Instance.new("Frame", main)
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1,0,0,32)
    titleBar.BackgroundTransparency = 1
    
    local titleLabel = Instance.new("TextLabel", titleBar)
    titleLabel.Size = UDim2.new(1,-8,1,0)
    titleLabel.Position = UDim2.new(0,4,0,0)
    titleLabel.Text = opts.Title or "RayFlex"
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
    
    self._gui = {ScreenGui = screenGui, Main = main, Content = content}
    
    -- Dragging
    local dragging = false
    local dragStart, startPos
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
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                      startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    return self
end

function Window:CreateSection(title)
    local sec = Section.new(title, self._gui.Content)
    table.insert(self.Sections, sec)
    return sec
end

return Window
