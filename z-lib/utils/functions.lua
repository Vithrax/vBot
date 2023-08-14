function to_boolean(str)
  if str == nil then
    return false
  end
  return string.lower(str) == 'true'
end

function has_array_value(arr, val)
  for index, value in ipairs(arr) do
    if value:trim() == val:trim() then
      return true
    end
  end
  return false
end

function table_length(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
