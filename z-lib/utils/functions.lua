function toBoolean(str)
	if str == nil then
		return false
	end
	return string.lower(str) == 'true'
end

function hasArrayValue(arr, val)
	for index, value in ipairs(arr) do
		if value:trim() == val:trim() then
			return true
		end
	end
	return false
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
