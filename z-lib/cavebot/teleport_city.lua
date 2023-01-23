CaveBot.Extensions.TeleportCity = {}

CaveBot.Extensions.TeleportCity.setup = function()
	CaveBot.registerAction("TeleportCity", "#ffffff", function(value)
		local teleportCities = {
			["aurora"] = {x=5645,y=5605,z=7},
			["dry creek"] = {x=6226,y=4775,z=7},
			["greenville"] = {x=0,y=0,z=0},
			["venore"] = {x=32957,y=32076,z=7},
			["thais"] = {x=32369,y=32241,z=7},
			["kazordoon"] = {x=32649,y=31925,z=11},
			["carlin"] = {x=32360,y=31782,z=7},
			["ab'dendriel"] = {x=32732,y=31634,z=7},
			["liberty bay"] = {x=32317,y=32826,z=7},
			["port hope"] = {x=32594,y=32745,z=7},
			["ankrahmun"] = {x=0,y=0,z=0},
			["darashia"] = {x=33213,y=32454,z=1},
			["edron"] = {x=33217,y=31814,z=8},
			["svargrond"] = {x=32212,y=31132,z=7},
			["yalahar"] = {x=32787,y=31276,z=7},
			["farmine"] = {x=33025,y=31553,z=10},
			["gray beach"] = {x=33447,y=31323,z=9},
			["roshamuul"] = {x=0,y=0,z=0},
			["krailos"] = {x=33657,y=31665,z=8},
			["rathleton"] = {x=33594,y=31899,z=6},
			["feyrist"] = {x=33479,y=32230,z=7},
			["issavi"] = {x=33921,y=31477,z=5},
		}
		local cityName = value:trim()
		local cityPosition = teleportCities[cityName]
		local playerPosition = player:getPosition()
		local timeLimitIgnore = 120
		local timeLimitRetries = 300

		if isPoisioned() and canCast("exana pox") then cast("exana pox")
		elseif isCursed() and canCast("exana mort") then cast("exana mort")
		elseif isBleeding() and canCast("exana kor") then cast("exana kor")
		elseif isBurning() and canCast("exana flam") then cast("exana flam")
		elseif isEnergized() and canCast("exana vis") then cast("exana vis")
		end

		-- if not storage.teleporterLastTps then
		-- 	storage.teleporterLastTps = {}
		-- end

		-- if storage.teleporterLastTps[cityName] and storage.teleporterLastTps[cityName]< os.time() + timeLimitIgnore then
		-- 	return false
		-- end

		if storage.teleporterLastTp == cityName then
			-- return false
		end

		if not storage.teleporterStarted then
			storage.teleporterStarted = os.time()
		end

		if storage.teleporterStarted + timeLimitRetries < os.time() then
			storage.teleporterStarted = nil
			return false
		end

		if playerPosition.z ~= cityPosition.z then
			NPC.say("!tp " .. cityName)
			return "retry"
		end

		if getDistanceBetween(playerPosition, cityPosition) > 10 then
			NPC.say("!tp " .. cityName)
			return "retry"
		end

		CaveBot.delay(CaveBot.Config.get("useDelay") + CaveBot.Config.get("ping"))
		storage.teleporterStarted = nil
		-- storage.teleporterLastTps[cityName] = os.time()
		storage.teleporterLastTp = cityName
		return true
	end)

	CaveBot.Editor.registerAction("teleportcity", "teleport city", {
		value="aurora",
		title="Teleport city",
		description="Teleport to a city",
		multiline=false
	})
end
