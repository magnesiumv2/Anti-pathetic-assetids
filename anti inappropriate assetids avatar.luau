local Players = game:GetService("Players")

local timer = 25
local kickMessage = "You failed to remove the prohibited clothing before the timer ended. Try again."

local prohibitedIds = {
	NumberHere,
	NumberHere,
}

local warnedPlayers = {}

local blacklist = {}
for _, id in ipairs(prohibitedIds) do
	blacklist[tostring(id)] = true
end

local function checkAvatar(character)
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return false end

	local description = humanoid:GetAppliedDescription()
	
	local clothing = {
		tostring(description.Shirt),
		tostring(description.Pants),
		tostring(description.GraphicTShirt)
	}

	for _, id in ipairs(clothing) do
		if blacklist[id] then
			return true
		end
	end

	for _, accessory in ipairs(description:GetAccessories(true)) do
		if blacklist[tostring(accessory.AssetId)] then
			return true
		end
	end

	return false
end

local function startCheck(player, character)
	if warnedPlayers[player.UserId] then return end

	if checkAvatar(character) then
		warnedPlayers[player.UserId] = true
		
		local shirt = character:FindFirstChildOfClass("Shirt")
		local pants = character:FindFirstChildOfClass("Pants")
		if shirt and blacklist[string.match(shirt.ShirtTemplate, "%d+") or ""] then
			shirt.ShirtTemplate = ""
		end
		if pants and blacklist[string.match(pants.PantsTemplate, "%d+") or ""] then
			pants.PantsTemplate = ""
		end

		task.delay(timer, function()
			warnedPlayers[player.UserId] = nil
			
			if player.Parent and player.Character then
				if checkAvatar(player.Character) then
					player:Kick(kickMessage)
				end
			end
		end)
	end
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAppearanceLoaded:Connect(function(character)
		startCheck(player, character)
	end)
end)
