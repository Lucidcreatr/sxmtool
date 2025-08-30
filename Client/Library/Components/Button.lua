-- Button.lua
local Button = {}
Button.__index = Button

function Button.new(parent, opts)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0,150,0,28)
    btn.Text = opts.label or "Button"
    btn.MouseButton1Click:Connect(function()
        if opts.callback then opts.callback() end
    end)
    return btn
end

return Button
