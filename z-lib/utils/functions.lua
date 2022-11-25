function toBoolean(str)
	if str == nil then
		return false
	end
	return string.lower(str) == 'true'
end

function tableLength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end

function curePoison()
	if isPoisioned() then
		say("exana pox")
	end
end

function checkBlessings()
	if player:getBlessings() == 0 then
		CaveBot.setOff()
	end
end

function setStorage()
	local places = {"darashia", "rathleton", "farmine"}
	if not storage.customRefill then
		storage.customRefill = {}
	end
	for _, place in places do
		if not storage.customRefill[place] then
			storage.customRefill[place] = false
		end
	end
end
