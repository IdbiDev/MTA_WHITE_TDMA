local screen = {guiGetScreenSize()};
local rel = screen[1]/1920;
local font = dxCreateFont("nametag.ttf",15,true)
local sc_font = dxCreateFont("sc_font.ttf",25,true)
local screenX, screenY = guiGetScreenSize()

function reMap(value, low1, high1, low2, high2)
    return low2 + (value - low1) * (high2 - low2) / (high1 - low1)
end

responsiveMultipler = reMap(screenX, 1024, 1920, 0.75, 1)

function resp(num)
    return num * responsiveMultipler
end

function respc(num)
    return math.ceil(num * responsiveMultipler)
end
function RenderNametags()
    for player,data in pairs(cache) do 
        if true then 
            local x,y,z = getPedBonePosition(player,6)
            local lx,ly,lz = getPedBonePosition(localPlayer,6)
            if (isLineOfSightClear(lx,ly,lz,x,y,z,true, false, false, true, false, true) and (getDistanceBetweenPoints3D(x,y,z,lx,ly,lz) < 20.0)) then 
                local sx,sy = getScreenFromWorldPosition(x,y,z+0.3, 0.06);
                if sx and sy then 
                    local progress = getDistanceBetweenPoints3D(x,y,z,lx,ly,lz)/20
                    local scale = interpolateBetween(1, 0, 0, 0.2, 0, 0, progress, "OutQuad")
                    scale = scale*rel
                    shadowedText("[#00fa62"..data.id.."#ffffff] "..exports.sos_admin:GetAdminSyntax(player).." ["..RGBToHex(getTeamColor(getPlayerTeam(player)))..getTeamName(getPlayerTeam(player)).."#ffffff]",sx-100,sy,sx+100,sy,tocolor(255,255,255,255),1*scale,font,"center","center")
                end
            end
        end
    end
end
addEventHandler("onClientRender",root,RenderNametags)
cache = {}
setTimer(function()
    cache = {}
    for _,player in pairs(getElementsByType("player")) do 
        cache[player] = {id = getElementData(player,"playerid")}
    end
end,1000,0)
-- Faszom lopunk
function RGBToHex(red, green, blue, alpha)
	
	-- Make sure RGB values passed to this function are correct
	if( ( red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255 ) or ( alpha and ( alpha < 0 or alpha > 255 ) ) ) then
		return nil
	end

	-- Alpha check
	if alpha then
		return string.format("#%.2X%.2X%.2X%.2X", red, green, blue, alpha)
	else
		return string.format("#%.2X%.2X%.2X", red, green, blue)
	end

end
function shadowedText(text,x,y,w,h,color,fontsize,font,aligX,alignY)
    dxDrawText(text:gsub("#%x%x%x%x%x%x",""),x,y+1,w,h+1,tocolor(0,0,0,255),fontsize,font,aligX,alignY, false, false, false, true) 
    dxDrawText(text:gsub("#%x%x%x%x%x%x",""),x,y-1,w,h-1,tocolor(0,0,0,255),fontsize,font,aligX,alignY, false, false, false, true)
    dxDrawText(text:gsub("#%x%x%x%x%x%x",""),x-1,y,w-1,h,tocolor(0,0,0,255),fontsize,font,aligX,alignY, false, false, false, true) 
    dxDrawText(text:gsub("#%x%x%x%x%x%x",""),x+1,y,w+1,h,tocolor(0,0,0,255),fontsize,font,aligX,alignY, false, false, false, true) 
    dxDrawText(text,x,y,w,h,color,fontsize,font,aligX,alignY, false, false, false, true)
end

--- Killog ((Like OOC chat))
OOCCache = {}
function insertOOC(killer,killed,weapon)
    if #OOCCache >= 10 then
		table.remove(OOCCache,10)
    end
    temp = {
        killer = killer, 
        killed = killed,
        weapon = weapon,
    }
    table.insert (OOCCache,1,temp)
end
addEvent("InsertNewKillMessage",true)
addEventHandler("InsertNewKillMessage",root,function(killer,killed,weapon)
    insertOOC(killer,killed,weapon)
end)
local oocfont = dxCreateFont("nametag.ttf",10);
function drawnOOC()
    if true then 
        --OOC
        
        local x,y = screen[1]-125, 64+(20*getChatboxLayout()["chat_lines"]);
        local shadow = false;
        for k,v in ipairs(OOCCache) do
            local ay = 165-(k*15)
            shadowedText(v.killer.."  "..v.weapon.."  "..v.killed, x, y + ay - 20, x+100, y + ay, tocolor(255,255,255,255), 1, oocfont, "right", "center",shadow)
        end
    end
end
addEventHandler("onClientRender", root, drawnOOC, true, "low-5")

--


function roundedRectangle(x, y, w, h, borderColor, bgColor, postGUI)
	if (x and y and w and h) then
		if (not borderColor) then
			borderColor = tocolor(0, 0, 0, 180)
		end
		if (not bgColor) then
			bgColor = borderColor
		end
		dxDrawRectangle(x, y, w, h, bgColor, postGUI);
		dxDrawRectangle(x + 2, y - 1, w - 4, 1, borderColor, postGUI);
		dxDrawRectangle(x + 2, y + h, w - 4, 1, borderColor, postGUI);
		dxDrawRectangle(x - 1, y + 2, 1, h - 4, borderColor, postGUI);
		dxDrawRectangle(x + w, y + 2, 1, h - 4, borderColor, postGUI);
        
        --Sarkokba pötty:
        dxDrawRectangle(x + 0.5, y + 0.5, 1, 2, borderColor, postGUI); -- bal felső
        dxDrawRectangle(x + 0.5, y + h - 1.5, 1, 2, borderColor, postGUI); -- bal alsó
        dxDrawRectangle(x + w - 0.5, y + 0.5, 1, 2, borderColor, postGUI); -- bal felső
        dxDrawRectangle(x + w - 0.5, y + h - 1.5, 1, 2, borderColor, postGUI); -- bal alsó
	end
end


local sc_W,sc_H = respc(200),respc(50)
local sc_X,sc_Y = screenX/2-sc_W/2, 1
function DrawUpperScoreBoard()

    dxDrawRectangle(sc_X,sc_Y,sc_W,sc_H,tocolor(127,127,127,255))
    roundedRectangle(sc_X-respc(90),sc_Y,respc(75),respc(50),tocolor(0,0,0,255))
    roundedRectangle(sc_X+respc(115)+sc_W/2,sc_Y,respc(75),respc(50),tocolor(255,255,255,255))

    shadowedText(timer or "10:00",sc_X,sc_Y,sc_X+sc_W,sc_H,tocolor(255,255,255,255),1,sc_font,"center","center")
---BLACK
    shadowedText(tostring(black or 0),sc_X-respc(90),sc_Y,sc_X-respc(90)+respc(75),respc(50),tocolor(255,255,255,255),0.85,sc_font,"center","center")
    --WHITE
    shadowedText(tostring(white or 0),sc_X+respc(115)+sc_W/2,sc_Y,sc_X+respc(115)+sc_W/2+respc(75),respc(50),tocolor(255,255,255,255),0.85,sc_font,"center","center")
end
addEventHandler("onClientRender",root,DrawUpperScoreBoard)

timer = "10:00"
addEvent("UpdateClock",true)
addEventHandler("UpdateClock",root,function(time)
    timer = convertSecondsToMinutes(tonumber(time))
end)
function convertSecondsToMinutes(sec) --turn the seconds into a MM:SS format 
    local temp = sec/60 
    local temp2 = (math.floor(temp)) --this equals the minutes 
    local temp3 = sec-(temp2*60) --and this is seconds 
    if string.len(temp3) < 2 then --make sure it's displayed correctly (MM:SS) 
        temp3 = "0"..tostring(temp3) 
    end 
    return tostring(temp2)..":"..tostring(temp3) 
end
white = 0
black = 0
addEvent("UpdateKills",true)
addEventHandler("UpdateKills",root,function(kills)
    white = kills[2]
    black = kills[1]
end)
addEvent("WinEffect",true)
addEventHandler("WinEffect",root,function(isWhite)
    if isWhite then  -- CT
        playSound("ct.mp3")
    else  -- T
        playSound("terror.mp3")
    end
    
end)