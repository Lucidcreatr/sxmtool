-- init.client.lua
-- 

local Library = {}
Library.__index = Library

local Core = require(script:WaitForChild("Core"))
local Theme = require(script:WaitForChild("Utils"):WaitForChild("Theme"))

function Library.new(opts)
    opts = opts or {}
    local self = setmetatable({}, Library)
    
   
    self.Core = Core.new()
    

    self.Theme = Theme.merge(Theme.default(), opts.theme or {})
    
    return self
end

function Library:CreateWindow(opts)
    return self.Core:CreateWindow(opts, self.Theme)
end

return Library
