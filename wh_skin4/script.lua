function savePlayerKills (thePlayer, acc)
	local acc = acc or getPlayerAccount (thePlayer)
	if not isGuestAccount(acc) and thePlayer then
		local setkills = getElementData (thePlayer, "kills") or 0
		local setdeaths = getElementData (thePlayer, "deaths") or 0
		setAccountData (acc, "kills", tostring(setkills))
		setAccountData (acc, "deaths", tostring(setdeaths))
	end
end

function loadPlayerKills (thePlayer)
	local acc = getPlayerAccount (thePlayer)
	if not isGuestAccount(acc) then
		local getKills = tonumber(getAccountData(acc, "kills")) or 0
		local getDeaths = tonumber(getAccountData(acc, "deaths")) or 0
		setElementData (thePlayer, "kills", getKills)
		setElementData (thePlayer, "deaths", getDeaths)
	end
end

addEventHandler ("onResourceStop", resourceRoot, function ()
	for i, p in pairs (getElementsByType("player")) do
		savePlayerKills (p)
	end
end)
 
addEventHandler ("onResourceStart", resourceRoot, function ()
	for i, p in pairs (getElementsByType("player")) do 
		loadPlayerKills (p)
	end
end)
 
addEventHandler ("onPlayerQuit", root, function ()
	savePlayerKills (source)
end)

addEventHandler ("onPlayerLogout", root, function (acc)
	savePlayerKills (source, acc)
end)
   
addEventHandler ("onPlayerLogin", root, function ()
	loadPlayerKills (source)
end)