--SQL Information
db = dbConnect( "mysql", "dbname=s12612_tdma;host=mysql.srkhost.eu;charset=utf8", "u12612_3OozCEF25c", "11p8OSDky0F2")
function getCon(res)
    outputServerLog(getResourceName(res).." Resource csatlakozott az adatbazishoz!")
    return db
end
ids = { }
black_kills = 0
white_kills = 0
setGameType("Team Deathmatch")
setMapName("Arena")
setRuleValue("Developer","Idbi")

addEventHandler("onPlayerJoin",root,function()
    setPlayerBlurLevel(source,0)
    LoadPlayer(source)
    setPlayerNametagShowing(source,false)
end)
addEventHandler("onResourceStart",resourceRoot,function()
    for _,player in pairs(getElementsByType("player")) do 
        setPlayerBlurLevel(player,0)
        LoadPlayer(player)
		ids[_] = player
		setElementData(player, "playerid", _)
        setPlayerNametagShowing(player,false)
    end
    setTeamFriendlyFire(Teams[1],false)
    setTeamFriendlyFire(Teams[2],false)
    setTeamColor(Teams[1],255,255,255)
    setTeamColor(Teams[2],0,0,0)
    setTimer(function()
        CreateRandomGame()
    end,1000,1)
    
end)

Teams = {createTeam("White"),createTeam("Black")}


function LoadPlayer(player)
    local team = SetandGetIDTeam(player)
    dbQuery(function(qh)
        local res = dbPoll(qh,0)
        if #res == 0 then 
            dbExec(db,"INSERT INTO accounts SET serial=?,nick=?",getPlayerSerial(player),getPlayerName(player):gsub("_"," "))
            LoadPlayer(player)
        else 
            spawnPlayer ( player, 0.0, 0.0, 3.0, 90.0, getElementModel(player),0,0,team )
            fadeCamera ( player, true)
            setCameraTarget ( player, player )
            outputChatBox("Szevasz #fa7600"..getPlayerName(player).."#FFFFFF. Üdv a szerón!",player,255,255,255,true)
            outputChatBox("#fa7600"..getPlayerName(player).."#FFFFFF fel lépett!",root,255,255,255,true)
            for key,val in pairs(res[1]) do 
                setElementData(player,key,val)
            end
            local c_team = getPlayerTeam(player)
        if getTeamName(c_team) == "White" then -- WHITE
            SetPosForPlaYER(player,"White_Spawn")
        else  -- Black <333
            SetPosForPlaYER(player,"Black_Spawn")
        end
            HandlePlayerWeapons(player)
        end
        triggerClientEvent(root,"UpdateKills",root,{black_kills,white_kills})  
    end,db,"SELECT * FROM accounts WHERE serial = ?",getPlayerSerial(player))
end




function SetandGetIDTeam(source)
	local slot = nil
	for i = 1, getMaxPlayers() do
		if (ids[i]==nil) then
			slot = i
			break
		end
	end
	ids[slot] = source
	setElementData(source, "playerid", slot)
    if slot %2==0 then 
        print("SELECTED TEAM: "..getTeamName(Teams[1]))
        return Teams[1]
    else 
        print("SELECTED TEAM: "..getTeamName(Teams[2]))
        return Teams[2]
    end
end
function SearchID(id)
    return ids[tonumber(id)]
end

function playerQuit()
	local slot = getElementData(source, "playerid")

	if (slot) then
		ids[slot] = nil
	end
    dbExec(db,"UPDATE accounts SET money=? WHERE serial=?",getElementData(source,"money"),getPlayerSerial(source))
    SaveWeapons(source)
    outputChatBox("#fa7600"..getPlayerName(source).."#FFFFFF elhagyta a szervert!",root,255,255,255,true)
end
addEventHandler("onPlayerQuit", getRootElement(), playerQuit)

addEventHandler( "onPlayerWasted", root,
	function()
        spawnPlayer ( source, 0.0, 0.0, 3.0,0,getElementModel(source))
        local c_team = getPlayerTeam(source)
        if getTeamName(c_team) == "White" then -- WHITE
            SetPosForPlaYER(source,"White_Spawn")
            black_kills = black_kills + 1
        else  -- Black <333
            SetPosForPlaYER(source,"Black_Spawn")
            white_kills = white_kills + 1
        end
        HandlePlayerWeapons(source)
        triggerClientEvent(root,"UpdateKills",root,{black_kills,white_kills})   
	end
)
function HeadShot ( attacker, weapon, bodypart, loss )
    if not getElementData(source,"protected") then 
        if ( bodypart == 9 and attacker and attacker ~= source ) then 
	        killPed ( source, attacker, weapon, bodypart )
	    end
    else
        cancelEvent() 
    end
end
addEventHandler ( "onPlayerDamage", root, HeadShot )

function player_Wasted ( ammo, attacker, weapon, bodypart )
    
	if ( attacker ) then
        local money = 50
		local tempString
		if ( getElementType ( attacker ) == "player" ) then
			tempString = getPlayerName ( attacker ).." megölte "..getPlayerName ( source ).."-t ("..getWeaponNameFromID ( weapon )..")"
		end
		if ( bodypart == 9 ) then
			tempString = tempString.." (Fejlövés!)"
            money = 100
		else
			tempString = tempString.." ("..getBodyPartName ( bodypart )..")"
		end
        triggerClientEvent(root,"InsertNewKillMessage",root,getPlayerName ( attacker ),getPlayerName ( source ),getWeaponNameFromID ( weapon )) 
		--outputChatBox ( tempString,root,255,255,255 )
        if attacker == source then 
           setElementData(source,"money",getElementData(source,"money")-100)
        else 
            setElementData(attacker,"money",getElementData(attacker,"money")+money)
        end
        
	else
		outputChatBox ( getPlayerName ( source ).." meghalt.",root,255,255,255 )
	end

end
addEventHandler ( "onPlayerWasted", root, player_Wasted )


function HandlePlayerWeapons(player)
    dbQuery(function(qh)
        local res = dbPoll(qh,0)
        local weaponlist = fromJSON(res[1].weapons) 
        for weapon,ammo in pairs(weaponlist[1]) do 
            giveWeapon(player,weapon,9999)
        end
    end,db,"SELECT * FROM accounts WHERE serial = ?",getPlayerSerial(player))
end
local weapons = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 22, 23, 24, 25, 26, 27, 28, 29, 32, 30, 31, 33, 34, 35, 36, 37, 38, 16, 17, 18, 39, 41, 42, 43, 10, 11, 12, 14, 15, 44, 45, 46, 40}
function GiveWeapons(player)
    for _,w in pairs(weapons) do
        giveWeapon(player,w,9999)
    end
end
addCommandHandler("weapons",GiveWeapons)

function SaveWeapons(player)
    local temp = {}
    for slot = 0, 12 do 
        local weapon = getPedWeapon ( player, slot ) 
        if ( weapon > 0 ) then 
            local ammo = getPedTotalAmmo ( player, slot ) 
            if ( ammo > 0 ) then 
                temp[weapon] = 9999
            end 
        end 
    end 
    dbExec(db,"UPDATE accounts SET weapons = ? WHERE serial = ?",toJSON({temp}),getPlayerSerial(player))
    dbExec(db,"UPDATE accounts SET money=? WHERE serial=?",getElementData(player,"money"),getPlayerSerial(player))
end
setTimer(function()
    for _,player in pairs(getElementsByType("player")) do 
        print(getPlayerName(player).." mentése!")
        SaveWeapons(player) 
    end
end,60000,0)
addEvent("RequestSave",true)
addEventHandler("RequestSave",root,function(player)
    SaveWeapons(player) 
end)

local maps = {
    [0] = {
        -- X,Y,Z,RADIUS,DIM,INT
        ["Name"] = "EasterBoardFarm",
        ["White_Spawn"] = {-18.958984375,1.2294921875,3.1096496582031,2,0,0},
        ["Black_Spawn"] = {23.26953125,-106.984375,0.609375,2,0,0},
    },
    [1] = {
        -- X,Y,Z,RADIUS,DIM,INT
        ["Name"] = "Ukrajna WTF DonE",
        ["White_Spawn"] = {645.91717529297,-2745.5651855469,1.8062499761581,2,0,0},
        ["Black_Spawn"] = {754.74237060547,-2901.4916992188,2.4553654193878,2,0,0},
    },
    [2] = {
        -- X,Y,Z,RADIUS,DIM,INT
        ["Name"] = "Gyár",
        ["White_Spawn"] = {2565.2900390625,-1285.3544921875,1044.125,2,0,2},
        ["Black_Spawn"] = {2543.271484375,-1318.1630859375,1031.421875,2,0,2},
    },
    [3] = {
        -- X,Y,Z,RADIUS,DIM,INT
        ["Name"] = "Jefferson Motel",
        ["White_Spawn"] = {2194.1640625,-1142.4755859375,1029.796875,2,0,15},
        ["Black_Spawn"] = {2222.2626953125,-1150.1494140625,1025.796875,2,0,15},
    },
}
Current_MAP = 0
function CreateRandomGame()
    newCurrent_MAP = math.random(0,#maps)
    if Current_MAP ~= newCurrent_MAP then 
        Current_MAP = newCurrent_MAP
        for _,player in pairs(getElementsByType("player")) do 
            local c_team = getPlayerTeam(player)
            if getTeamName(c_team) == "White" then -- WHITE
                SetPosForPlaYER(player,"White_Spawn")
            else  -- Black <333
                SetPosForPlaYER(player,"Black_Spawn")
            end
        end
        outputChatBox("[#fa7600White TDMA#FFFFFF] Mostani map: #fa7600"..maps[Current_MAP]["Name"],root,255,255,255,true)
        NewGame()
    else
        CreateRandomGame()
    end
end
function ForceSetMap(id)
    Current_MAP = tonumber(id)
    for _,player in pairs(getElementsByType("player")) do 
        local c_team = getPlayerTeam(player)
        if getTeamName(c_team) == "White" then -- WHITE
            SetPosForPlaYER(player,"White_Spawn")
        else  -- Black <333
            SetPosForPlaYER(player,"Black_Spawn")
        end
    end
    outputChatBox("[#fa7600White TDMA#FFFFFF] Mostani map: #fa7600"..maps[Current_MAP]["Name"],root,255,255,255,true)
    NewGame()
end
addCommandHandler("getpos",function(source,cmd)
    local x,y,z = getElementPosition(source)
    local dim = getElementDimension(source)
    local int = getElementInterior(source)
    outputChatBox(x..","..y..","..z,source)
    outputChatBox("DIM: "..dim.." > < INT: "..int,source)

end)
addCommandHandler("gopos",function(source,cmd,x,y,z)
    setElementPosition(source,x,y,z)
end)
addCommandHandler("switchmap",function(source,cmd)
    CreateRandomGame()
end)
addCommandHandler("setmap",function(source,cmd,id)
    ForceSetMap(id)
end)


function SetPosForPlaYER(player,team)
    local x,y,z = maps[Current_MAP][team][1],maps[Current_MAP][team][2],maps[Current_MAP][team][3]
    local rad = maps[Current_MAP][team][4]
    local nx,ny = math.random(x,x+rad),math.random(y,y+rad)
    setElementPosition(player,nx,ny,z+1)
    setElementInterior(player,maps[Current_MAP][team][6])

    setElementAlpha(player,110)
    setElementData(player,"protected",true)
    setTimer(function()
        setElementData(player,"protected",false)
        setElementAlpha(player,255)
    end,5000,1)
end

local countdown
local counter
function NewGame()
    black_kills = 0
    white_kills = 0
    triggerClientEvent(root,"UpdateKills",root,{black_kills,white_kills})  
    countdown = setTimer(countdownFin, 600000, 1)
    --countdown = setTimer(countdownFin, 120000, 1)
    counter = setTimer(function() 
                local x = getTimerDetails(countdown) 
                local timeLeft = math.ceil(x/1000) 
                triggerClientEvent(root,"UpdateClock",root,timeLeft)
            end, 1000, 0) 
end
function countdownFin() 
    killTimer(counter)
    killTimer(countdown)
    triggerClientEvent(root,"WinEffect",root,(white_kills > black_kills))
    setTimer(function()
        CreateRandomGame()
    end,5000,1)
end 
  
