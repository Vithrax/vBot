setDefaultTab("Main")

-- montaria sempre

macro(250, "Montar Sempre", function()
   local player = g_game.getLocalPlayer()
  if player then 
    player:mount()
  end
end)
-- Super Dash

function superDash(parent)
 if not parent then
    parent = panel
  end
  local switch = g_ui.createWidget('BotSwitch', parent)
  switch:setId("superDashButton")
  switch:setText("Super Dash")
  switch:setOn(storage.superDash)
  switch.onClick = function(widget)    
    storage.superDash = not storage.superDash
    widget:setOn(storage.superDash)
  end

  onKeyPress(function(keys)
    if not storage.superDash then
      return
    end
    consoleModule = modules.game_console
    if (keys == "W" and not consoleModule:isChatEnabled()) or keys == "Up" then
      moveToTile = g_map.getTile({x = posx(), y = posy()-1, z = posz()})
      if moveToTile and not moveToTile:isWalkable(false) then
        moveToPos = {x = posx(), y = posy()-6, z = posz()}
        dashTile = g_map.getTile(moveToPos)
        if dashTile then
          g_game.use(dashTile:getTopThing())
        end
      end
    elseif (keys == "A" and not consoleModule:isChatEnabled()) or keys == "Left" then
      moveToTile = g_map.getTile({x = posx()-1, y = posy(), z = posz()})
      if moveToTile and not moveToTile:isWalkable(false) then
        moveToPos = {x = posx()-6, y = posy(), z = posz()}
        dashTile = g_map.getTile(moveToPos)
        if dashTile then
          g_game.use(dashTile:getTopThing())
        end
      end
    elseif (keys == "S" and not consoleModule:isChatEnabled()) or keys == "Down" then
      moveToTile = g_map.getTile({x = posx(), y = posy()+1, z = posz()})
      if moveToTile and not moveToTile:isWalkable(false) then
        moveToPos = {x = posx(), y = posy()+6, z = posz()}
        dashTile = g_map.getTile(moveToPos)
        if dashTile then
          g_game.use(dashTile:getTopThing())
        end
      end
    elseif (keys == "D" and not consoleModule:isChatEnabled()) or keys == "Right" then
      moveToTile = g_map.getTile({x = posx()+1, y = posy(), z = posz()})
      if moveToTile and not moveToTile:isWalkable(false) then
        moveToPos = {x = posx()+6, y = posy(), z = posz()}
        dashTile = g_map.getTile(moveToPos)
        if dashTile then
          g_game.use(dashTile:getTopThing())
        end
      end
    end
  end)
end
superDash()

--- click reuse

local reUseToggle = macro(1000, "Click ReUse", "", function() end)
local excluded = { } 

onUseWith(function(pos, itemId, target, subType)
  if reUseToggle.isOn() and not table.find(excluded, itemId) then
    schedule(50, function()
      item = findItem(itemId)
      if item then
        modules.game_interface.startUseWith(item)
      end
    end)
  end
end)






-- cata itens
local sla = {2644, 2667, 16129, 16110, 7532, 3246, 11688, 3394, 3393, 3437, 30401, 3213, 14674, 27449, 31616,
             21962, 21963, 28897, 27451, 23442, 23443, 3253, 34109, 14112, 3001, 31578, 24395, 11693, 31557, 
             31621, 25361, 25780, 28493, 28571, 22755, 28484, 27455, 29426, 20347, 22151, 22152, 14682, 27452, 
             6526, 27845, 27846, 30396, 30394, 30395, 31678, 30393, 11674, 30397, 30400, 30398, 30399, 20271, 
             22722, 23684, 25981, 27456, 20064, 20082, 20073, 20085, 20079, 20076, 20067, 20088, 16161, 5924,
             32703, 3388, 3389, 13997, 13995, 14258, 13994, 13996, 13998, 5919, 16262, 16263, 22027, 10477, 
             12572, 31265, 12043, 12044, 25979, 20063, 29423, 36827, 3397, 3396, 3398, 8054, 22521, 22522,
             22523, 22535, 22531, 29430, 36664, 36667, 36836, 36657, 36670, 36663, 36672, 36661, 36671, 36666,
             36674, 36656, 36673, 36668, 36659, 11689, 3399, 31579, 8102, 30344, 30345, 30342, 30343, 30402,
             30403, 22115, 22130, 22114, 22129, 22116, 22132, 22088, 22127, 22113, 22128, 23678, 23525, 28830,
             29425, 35523, 35516, 32617, 28724, 28718, 28714, 28715, 28722, 28720, 28723, 28725, 28719, 28716,
             28721, 28717, 10798, 10799, 22767, 5903, 34019, 34021, 34020, 34018, 33953, 33952, 31738, 8053,
             22518, 22519, 22520, 22534, 22530, 9018, 9019, 36951, 36952, 36953, 36954, 36955, 36956, 36838,
             23536, 14143, 27565, 14142, 22527, 22528, 22529, 22537, 22533, 12041, 12042, 19391, 4100, 32620,
             32628, 32631, 36665, 36658, 36662, 36675, 36669, 36660, 16105, 16104, 16106, 25732, 27648, 27647,
             27649, 27650, 27651, 22721, 36994, 3555, 8148, 8175, 28896, 3365, 20273, 14172, 3303, 3422, 7450,
             27454, 25360, 8096, 9382, 3229, 19359, 12260, 30168, 19362, 19366, 8079, 7435, 22760, 16153, 29944,
             29945, 8778, 35518, 35514, 35524, 35521, 35522, 7532, 28791, 34158, 34253, 34254, 34150, 34155,
             34157, 34151, 34154, 34156, 34153, 34152, 22120, 22121, 37058, 29418, 29417, 25632, 25633, 25634,
             31267, 10476, 37059, 27453, 12599, 36978, 36979, 3278, 3288, 30088, 8060, 29942, 9372, 5785, 31591,
             14762, 14763, 33928, 33925, 20355, 21947, 21948, 32759, 32760, 32758, 32761, 16128, 9604, 25975,
             16244, 9378, 6432, 29947, 10227, 20274, 6390, 21982, 16275, 16276, 8154, 8157, 19150, 5804, 3244,
             13993, 13999, 14000, 5808, 29424, 32619, 3549, 6529, 34097, 34098, 19159, 28821, 29429, 32616,
             3334, 10341, 3215, 3439, 4115, 4124, 22026, 24393, 22759, 30087, 32075, 32074, 32076, 36837, 35576,
             32764, 36869, 36867, 32765, 36868, 36865, 36866, 30169, 16110, 16112, 16109, 16111, 16114, 16116,
             35577, 31556, 30323, 8077, 17825, 29419, 32621, 32636, 8038, 27458, 3427, 8023, 11686, 11687, 10346,
             6511, 6567, 27591, 6531, 32746, 20313, 20314, 10338, 31485, 31737, 9380, 11688, 22890, 22889, 3417,
             16175, 29420, 32077, 31592, 22516, 7423, 27450, 29428, 11692, 8097, 10345, 5809, 34099, 34084, 34088,
             34086, 34082, 34085, 32591, 32618, 34091, 34087, 34095, 34089, 34092, 34094, 34083, 34096, 34093,34090,
             8080, 34074, 34072, 34073, 32629, 14769, 8090, 16107, 29431, 10343, 9596, 9597, 25976, 29421, 31574,
             25779, 31614, 3442, 31577, 8081, 8104, 31631, 30275, 30276, 31576, 14768, 35515, 22524, 22525, 22526,
             22536, 22532, 22118, 23474, 23475, 8149, 8174, 34264, 34265, 34266, 34267, 3997, 4010, 19356, 9383,
             20071, 20065, 20083, 20074, 20086, 20080, 20077, 20072, 20084, 20075, 20087, 20081, 20078, 20069, 20090,
             20066, 20068, 20089, 31623, 31624, 31622, 8191, 8192, 8040, 23538, 23476, 23477, 27457, 12603, 3296,
             3569, 31625, 31617, 3368, 29422, 22084, 9020, 6530, 8862, 8863, 8864, 18339, 16242, 3043 } -- ID dos itens
             
macro(100, "Cata Itens", function()
local z = posz()
for _, tile in ipairs(g_map.getTiles(z)) do
if z ~= posz() then return end
if getDistanceBetween(pos(), tile:getPosition()) <= 10 then -- distância que quer coletar
if table.find(sla, tile:getTopLookThing():getId()) then
g_game.move(tile:getTopLookThing(), {x = 65535, y=SlotBack, z=0}, tile:getTopLookThing():getCount())
end
end
end
end)



