-- InputUtils.lua
local UserInputService = game:GetService("UserInputService")
local InputUtils = {}

function InputUtils:IsKeyDown(key)
    return UserInputService:IsKeyDown(Enum.KeyCode[key])
end

return InputUtils
