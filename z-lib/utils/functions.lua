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