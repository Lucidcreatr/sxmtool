-- Section.lua
local Section = {}
Section.__index = Section

function Section.new(title, parent)
    local self = setmetatable({}, Section)
    self.Elements = {}
    
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1, -8, 0, 120)
    frame.Position = UDim2.new(0, 4, 0, #parent:GetChildren() * 126)
    frame.BackgroundTransparency = 1
    
    local label = Instance.new("TextLabel", frame)
    label.Text = title or "Section"
    label.Size = UDim2.new(1,0,0,20)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    
    self._gui = frame
    return self
end

function Section:Toggle(opts)
    local btn = Instance.new("TextButton", self._gui)
    btn.Text = opts.label or "Toggle"
    btn.Size = UDim2.new(0,150,0,28)
    btn.Position = UDim2.new(0,0,0,#self.Elements*32)
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = (state and "On" or "Off").." - "..(opts.label or "Toggle")
        if opts.callback then opts.callback(state) end
    end)
    
    table.insert(self.Elements, btn)
    return btn
end

return Section
