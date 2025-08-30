-- Theme.lua
local Theme = {}

function Theme.default()
    return {
        BackgroundColor = Color3.fromRGB(18,18,18),
        PrimaryColor = Color3.fromRGB(0,170,255),
        TextColor = Color3.fromRGB(255,255,255)
    }
end

function Theme.merge(base, override)
    local result = {}
    for k,v in pairs(base) do result[k] = v end
    for k,v in pairs(override) do result[k] = v end
    return result
end

return Theme
