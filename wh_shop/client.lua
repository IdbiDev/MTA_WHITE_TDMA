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

local barW = 500
local barH = 35

local barX = screenX / 2 - barW / 2
local barY = screenY / 2 - barH / 2

local timeout_tick = 0

state = false

local currentCategory = 1

local title_font = dxCreateFont(":wh_core/nametag.ttf",15)
if not title_font then 
    outputChatBox("Anyád")
end

-- Credit Szilárdnak <333333333 
function showPanel()
    if not (timeout_tick+2000 <= getTickCount()) then 
        return
    else 
        state = not state
        if state then
            alphaAnimation = {getTickCount(), 0, 1} -- Itt bejön alphazodva a panel
            movAnimation = {getTickCount(), 0, 1} -- Itt bejön alphazodva a panel
            addEventHandler("onClientRender", root, renderBar)
            IsSelected = false
        else
            -- Itt kialphazodik
            movAnimation = {getTickCount(), 1, 0} -- Itt bejön alphazodva a panel
            setTimer(function()
                setTimer(function()
                    removeEventHandler("onClientRender", root, renderBar)
                end,250,1)
                alphaAnimation = {getTickCount(), 1, 0}
            end,500,1)
        end
        timeout_tick = getTickCount()
    end

end
bindKey("F1","down",showPanel)
alpha = 0
IsSelected = false
function renderBar()
    if alphaAnimation then
        local now = getTickCount()

        local alphaProgress = (now - alphaAnimation[1]) / 250

        alpha = interpolateBetween(alphaAnimation[2], 0, 0, alphaAnimation[3], 0, 0, alphaProgress, "Linear")
    end
    if movAnimation then
        local now = getTickCount()

        local movProg = (now - movAnimation[1]) / 750

        pan_y = interpolateBetween(movAnimation[2], 0, 0, movAnimation[3], 0, 0, movProg, "Linear")
    end
    dxDrawRectangle(barX, barY-(200*pan_y), barW, barH+(300*pan_y), tocolor(0, 0, 0, 150*alpha))
    dxDrawRectangle(barX, barY-(200*pan_y), barW, respc(35), tocolor(15, 15, 15, 255*alpha))
    dxDrawText("White TDMA - Shop", barX, barY-(200*pan_y), barX + barW, barY + respc(35)-(200*pan_y), tocolor(255, 255, 255, 255*alpha), 0.95, title_font, "center", "center")
    if pan_y == 1 then 
        DrawFaszsagok()
        dxDrawOuterBorder(barX, barY-(200*pan_y), barW, barH+(300*pan_y),2,tocolor(10,10,10,255))
    end
end
function DrawFaszsagok()
    dxDrawText(formatMoney((getElementData(localPlayer,"money") or 0),".").."$", barX, barY-145, barX + barW, barY-140, tocolor(255, 255, 255, 255*alpha), 0.95, title_font, "center", "center")
   -- dxDrawRectangle(barX+barW/2, barY-132, barW/2-150, respc(2), tocolor(255, 255, 255, 110))
   -- dxDrawRectangle(barX+barW/2, barY-132, -(barW/2-150), respc(2), tocolor(255, 255, 255, 110))
    for i=0,2 do 
        for k=0,3 do 
            if isInSlot(barX+(k*125)+10, barY+(i*75)-barH/2-100, respc(100), respc(50)) then 
                dxDrawRectangle(barX+(k*125)+10, barY+(i*75)-barH/2-100, respc(100), respc(50), tocolor(30, 30, 30, 200))
                dxDrawText(getWeaponNameFromID(weapons[i+1][k+1][1]), barX+(k*125)+10, barY+(i*75)-barH/2-100,barX+(k*125)+10+ respc(100),  barY+(i*75)-barH/2-100+respc(50), tocolor(255, 255, 255, 255), 0.85, title_font, "center", "center")
                dxDrawOuterBorder(barX+(k*125)+10, barY+(i*75)-barH/2-100, respc(100), respc(50),2,tocolor(255,255,255,110))
            else 
                dxDrawRectangle(barX+(k*125)+10, barY+(i*75)-barH/2-100, respc(100), respc(50), tocolor(15, 15, 15, 175))
                dxDrawText(getWeaponNameFromID(weapons[i+1][k+1][1]), barX+(k*125)+10, barY+(i*75)-barH/2-100,barX+(k*125)+10+ respc(100),  barY+(i*75)-barH/2-100+respc(50), tocolor(255, 255, 255, 200), 0.85, title_font, "center", "center")
                dxDrawOuterBorder(barX+(k*125)+10, barY+(i*75)-barH/2-100, respc(100), respc(50),2,tocolor(0,0,0,255))
            end
            if isInSlot(barX+(k*125)+10, barY+(i*75)-barH/2-100, respc(100), respc(50)) and timeout_tick+1000 <= getTickCount() and getKeyState("mouse1") then
                IsSelected = {getWeaponNameFromID(weapons[i+1][k+1][1]),weapons[i+1][k+1][2]}
                timeout_tick = getTickCount()
                
            end
        end
    end
    if IsSelected then 
        
        dxDrawRectangle( barX,barY+100,barW,35,tocolor(10,10,10,110))
        dxDrawOuterBorder(barX,barY+100,barW,35,5,tocolor(10,10,10,110))
        dxDrawText("Kiválasztott fegyver: "..IsSelected[1], barX, barY+100, barX + barW, barY+100, tocolor(255, 255, 255, 255*alpha), 0.85, title_font, "left", "top")
        dxDrawText("Ár: "..IsSelected[2].."$", barX, barY+100, barX + barW, barY+100, tocolor(255, 255, 255, 255*alpha), 0.95, title_font, "right", "top")
        DrawButton("Vásárlás", barX+barW/2,barY+100,150,30,{10,10,10,150},2)
        if isInSlot( barX+barW/2,barY+100,150,30) and getKeyState("mouse1") and timeout_tick+1000 <= getTickCount()  then 
            triggerServerEvent("onWeaponBuyed",localPlayer,localPlayer,IsSelected)
            timeout_tick = getTickCount()
        end
    end 
end
weapons = {
    {{30,5000},{31,10000},{29,2000},{34,5000}},
    {{24,500},{28,2500},{32,1000},{23,300}},
    {{4,50},{27,15000},{26,10000},{38,100000}},
}
bindKey("m","down",function() showCursor(not isCursorShowing())end)

local cursorState = isCursorShowing()
local cursorX, cursorY = screenX/2, screenY/2
if cursorState then
    local cursorX, cursorY = getCursorPosition()
    cursorX, cursorY = cursorX * screenX, cursorY * screenY
end

addEventHandler("onClientCursorMove", root, 
    function(_, _, x, y)
        cursorX, cursorY = x, y
    end
)

function isInBox(dX, dY, dSZ, dM, eX, eY)
    if eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM then
        return true
    else
        return false
    end
end

function isInSlot(xS,yS,wS,hS)
    if isCursorShowing() then
        if isInBox(xS,yS,wS,hS, cursorX, cursorY) then
            return true
        else
            return false
        end
    end 
end
-- Megint Credit to Szilard
function dxDrawOuterBorder(x, y, w, h, margin, bordercolor)
    bordercolor = bordercolor or tocolor(0, 0, 0, 180)

    dxDrawRectangle(x - margin, y - margin, w + (margin * 2), margin, bordercolor) -- felső
    dxDrawRectangle(x - margin, y + h, w + (margin * 2), margin, bordercolor) -- alsó

    dxDrawRectangle(x - margin, y, margin, h + margin, bordercolor) -- bal
    dxDrawRectangle(x + w, y, margin, h + margin, bordercolor) -- jobb
end
function formatMoney(amount, stepper)
    local left, center, right = string.match(math.floor(amount), "^([^%d]*%d)(%d*)(.-)$")
    return left .. string.reverse(string.gsub(string.reverse(center), "(%d%d%d)", "%1" .. (stepper or " "))) .. right
end
    
function DrawButton(text,x,y,w,h,color,fontSize)
    local r,g,b,a = unpack(color);
    local hoverColor = tocolor(r,g,b,a-40);
    if isInSlot(x,y,w,h) then 
        hoverColor = tocolor(r,g,b,a+10);
    end
	roundedRectangle(x,y,w,h,false,hoverColor);
    --dxDrawBorder(x,y,w,h,resFont(2),tocolor(r,g,b));
    dxDrawText(text,x,y,x + w,y + h,tocolor(255,255,255),1,title_font,"center","center");
end

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