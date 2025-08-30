-- Core.lua
local Window = require(script:WaitForChild("Components"):WaitForChild("Window"))
local Section = require(script:WaitForChild("Components"):WaitForChild("Section"))

local Core = {}
Core.__index = Core

function Core.new()
    local self = setmetatable({}, Core)
    self.Windows = {}
    return self
end

function Core:CreateWindow(opts, theme)
    local win = Window.new(opts, theme)
    table.insert(self.Windows, win)
    return win
end

return Core

