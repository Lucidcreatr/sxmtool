-- src/Client/Library/init.client.lua
local Library = {}
Library.__index = Library

local Core = require(script:WaitForChild("Core"))
local Theme = require(script:WaitForChild("Utils"):WaitForChild("Theme"))

function Library.new(opts)
    opts = opts or {}
    local self = setmetatable({}, Library)
    self.core = Core.new(opts)
    self.theme = Theme.merge(Theme.default(), opts.theme or {})
    return self
end

function Library:CreateWindow(windowOptions)
    return self.core:CreateWindow(windowOptions, self.theme)
end

return Library

