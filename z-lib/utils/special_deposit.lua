if not storage.specialDeposit then
	storage.specialDeposit = {
		items = {},
		last = false,
		height = 380
	}
end

storage.sellLootList = {
	aurora = {
		index = 6,
		items = {7426,7404,3344,10457,7403,7406,7429,3408,17829,3435,8022,7427,11674,8027,7415,16163,3333,8050,3420,3019,7382,7387,8057,3386,7402,7430,7419,3326,815,823,829,824,819,3063,3360,3364,3315,3332,7380,3340,12683,7389,7422,8049,9303,820,828,822,816,825,7424,3366,817,818,826,821,827,7463,3414,3436,7386,16164,7384,3314,7418,7456,7392,17828,8063,3055,7383,3006,7434,3016,6553,9302,7437,9304,5741,8061,7452,3554,8052,3442,814,813,830,812,811,7390,7388,3342,9653,7428,3322,3281,7407,3370,3318,3371,7421,7411,3324,7413,3428,3434,3369,16118,3067,16117,8083,3065,8082,8084,3073,16096,8093,16115,3071,8092,8094,7436,3567,3079,7412,3381,3385,3382,3419,3391,3302,3416,7454,3284,3415,3320,3280,3439,7410,3392,7451}
	},
	yalahar = {
		index = 7,
		items = {3041,3038,3039,3036,3037}
	},
	farmine = {
		index = 8,
		items = {10391,4033,10388,11651,10323,10389,11657,10384,10385,10387,10386,10390}
	},
	edron = {
		index = 9,
		items = {9103,8043,10451,10438,10439}
	},
	darashia = {
		index = 10,
		items = {23526,23542,23543,23544,23529,23530,23531,23532,23533,23534}
	},
	graybeach = {
		index = 11,
		items = {14086,14088,13991,14250,13987,13998,14087,14043,14246,14089,13990,14247,14001,14040,14042,14083,14079,14011,14044,14010,14041,14017,14012,14013,14225,12730,14077,14008,14082,14078,14076,14080,14081}
	}
}

if tableLength(storage.specialDeposit.items) < 1 then
	for key, sellLootConfig in pairs(storage.sellLootList) do
		for index, itemId in ipairs(sellLootConfig.items) do
			table.insert(storage.specialDeposit.items, {id=itemId,index=sellLootConfig.index})
		end
	end
end
