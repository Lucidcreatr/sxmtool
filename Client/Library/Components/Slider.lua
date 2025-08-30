-- Slider.lua
local Slider = {}
Slider.__index = Slider

function Slider.new(parent, opts)
    local self = setmetatable({}, Slider)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(0, 200, 0, 28)
    
    local bar = Instance.new("Frame", frame)
    bar.Size = UDim2.new(1,0,1,0)
    bar.BackgroundColor3 = Color3.fromRGB(50,50,50)
    
    local fill = Instance.new("Frame", bar)
    fill.Size = UDim2.new(0,0,1,0)
    fill.BackgroundColor3 = Color3.fromRGB(100,200,100)
    
    local dragging = false
    local UserInputService = game:GetService("UserInputService")
    
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    bar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local pos = math.clamp(input.Position.X - bar.AbsolutePosition.X, 0, bar.AbsoluteSize.X)
            fill.Size = UDim2.new(pos/bar.AbsoluteSize.X,0,1,0)
            if opts.callback then
                opts.callback(pos/bar.AbsoluteSize.X)
            end
        end
    end)
    
    return self
end

return Slider
