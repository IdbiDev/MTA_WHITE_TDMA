local screenW, screenH = guiGetScreenSize ( )
local resW, resH = 1366, 768
local x, y =  ( screenW/resW ), ( screenH/resH )

local fenixFONT = dxCreateFont("Arquivos/Font.ttf", 11)
local fenixFONT1 = dxCreateFont("Arquivos/Font.ttf", 10)
local font = dxCreateFont("font.ttf",20)

function convertNumber ( number )   
    local formatted = number   
    while true do       
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')     
        if ( k==0 ) then       
            break   
        end   
    end   
    return formatted 
end
function formatMoney(amount, stepper)
local left, center, right = string.match(math.floor(amount), "^([^%d]*%d)(%d*)(.-)$")
return left .. string.reverse(string.gsub(string.reverse(center), "(%d%d%d)", "%1" .. (stepper or " "))) .. right
end

function AirNewSCR_Hud ( )
   -- if getElementData ( localPlayer, "AirNewSCR_Logado" ) == "Sim" then
	    if getElementData ( localPlayer, "AirNewSCR_Scoreboard" ) == "Aberto" then return end
	    local quantiasuja = tonumber(getElementData ( getLocalPlayer(), "DinheiroSujo"  )) or 0
	    local Dinheiro_Mao = getPlayerMoney ( localPlayer ) or 0
		if Dinheiro_Mao > 0 then
		    Dinheiro_Mao = convertNumber ( Dinheiro_Mao )
		else
		    Dinheiro_Mao = Dinheiro_Mao
		end
		if quantiasuja > 0 then
		    quantiasuja = convertNumber ( quantiasuja )
		else
		    quantiasuja = quantiasuja
		end
		setElementData ( localPlayer, "Dinheiro na Mão", "$"..Dinheiro_Mao.."" )
	    local Dinheiro_Banco = getElementData ( localPlayer, "Bank:Caixa" ) or 0
		if Dinheiro_Banco > 0 then
		    Dinheiro_Banco = convertNumber ( Dinheiro_Banco )
		else
		    Dinheiro_Banco = Dinheiro_Banco
		end
		setElementData ( localPlayer, "Dinheiro no Banco", "$"..Dinheiro_Banco.."" )
	    
	    local AirNewSCR_Fome = getElementData ( localPlayer, "AirNewSCR_Fome" ) or 0
        local AirNewSCR_Sede = getElementData ( localPlayer, "AirNewSCR_Sede" ) or 0
		
		if AirNewSCR_Fome > 0 then
		    AirNewSCR_Fome = math.floor ( AirNewSCR_Fome )
		else
		    AirNewSCR_Fome = 0
		end
		
		if AirNewSCR_Sede > 0 then
		    AirNewSCR_Sede = math.floor ( AirNewSCR_Sede )
		else
		    AirNewSCR_Sede = 0
		end
		
		local vida1 = math.floor(getElementHealth(getLocalPlayer()))
        local vida2 = getPedMaxHealth(getLocalPlayer())
		local colete = math.floor(getPedArmor(getLocalPlayer()))
		local weapon = getPedWeapon(getLocalPlayer())
		local ID = getElementData(localPlayer,"playerid") or "N/A"
		local sujo = convertNumber(getElementData(localPlayer, "Dinheiro:Sujo") or "0")
		local Level = getElementData(localPlayer,"Level") or 0
		local EXP = getElementData(localPlayer,"Exp") or 0
        local procurado = getPlayerWantedLevel(getLocalPlayer())
	    local weaponClip = getPedAmmoInClip(getLocalPlayer(), getPedWeaponSlot(getLocalPlayer()))
	    local weaponAmmo = getPedTotalAmmo(getLocalPlayer()) - getPedAmmoInClip(getLocalPlayer())		
		---
		if AirNewSCR_Sede > 0 then
		    AirNewSCR_Sede = math.floor ( AirNewSCR_Sede )
		else
		    AirNewSCR_Sede = 0
		end
		
		if getElementData(getLocalPlayer(),"FPS") then
			playerFPS = getElementData(getLocalPlayer(),"FPS")
		else
			playerFPS = 0
		end
		
		-----MINHA HUD
		dxDrawImage(screenW * 0.8653, screenH * 0.0117, screenW * 0.1245, screenH * 0.0951, "Arquivos/fundo.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.8909, screenH * 0.0260, screenW * 0.0915/vida2*vida1, screenH * 0.0273, tocolor(255, 0, 0, 255), false)
        dxDrawRectangle(screenW * 0.8909, screenH * 0.0638, screenW * 0.0915/100*colete, screenH * 0.0273, tocolor(255, 0, 254, 255), false)
        dxDrawText("FPS: "..playerFPS, screenW * 0.87, screenH * 0.1068, screenW * 0.95, screenH * 0.1341, tocolor(255, 255, 255, 255), 1.00, "clear", "left", "top", false, false, false, false, false)
        dxDrawText("ID: "..ID, screenW * 0.9348, screenH * 0.1068, screenW * 0.9773, screenH * 0.1315, tocolor(255, 255, 255, 255), 1.00, "default", "right", "top", false, false, false, false, false)
        dxDrawImage(screenW * 0.8682, screenH * 0.0273, screenW * 0.0190, screenH * 0.0260, "Arquivos/vida1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(screenW * 0.8690, screenH * 0.0651, screenW * 0.0183, screenH * 0.0260, "Arquivos/colete1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)

        dxDrawText(""..weaponClip.."/"..weaponAmmo, x*0.3521, y*0.8997, x*0.2189, y*0.1758, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, true, false)
		local time = getRealTime()
        local hours = time.hour
        local minutes = time.minute
        local seconds = time.second
		--dxDrawText("["..hours..":"..minutes.."]", screenW * 0.9012, screenH * 0.1432, screenW * 0.9773, screenH * 0.1680, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
		dxDrawText(formatMoney(getElementData(localPlayer,"money"),".").."$", screenW-10 , screenH * 0.12, screenW-10, screenH * 0.3, tocolor(255, 255, 255, 255), 1, font, "right", "top", false, false, false, true, false)

	end
addEventHandler ( "onClientRender", getRootElement(), AirNewSCR_Hud )

function toggleRadar()
	if isVisible then
		addEventHandler("onClientRender", root, AirNewSCR_Hud )
	else
		removeEventHandler("onClientRender", root, AirNewSCR_Hud )
	end
	isVisible = not isVisible
end
bindKey ("F11", "down", toggleRadar)

local components = {"weapon", "ammo", "health", "clock", "money", "breath", "armour", "wanted", "vehicle_name", "area_name", "radio","radar"}
function onClientResourceStart()
	sAlpha = 200
	for _, component in ipairs(components) do
		setPlayerHudComponentVisible(component, false)
	end
end
addEventHandler("onClientResourceStart", resourceRoot, onClientResourceStart)

function onClientResourceStop()
	for _, component in ipairs(components) do
		setPlayerHudComponentVisible(component, true)
	end
end
addEventHandler("onClientResourceStop", resourceRoot, onClientResourceStop)

function getPedMaxHealth(ped)
	assert(isElement(ped) and (getElementType(ped) == "ped" or getElementType(ped) == "player"), "Bad argument @ 'getPedMaxHealth' [Expected ped/player at argument 1, got " .. tostring(ped) .. "]")
	local stat = getPedStat(ped, 24)
	local maxhealth = 100 + (stat - 569) / 4.31
	return math.max(1, maxhealth)
end

function isCursorOnElement( posX, posY, width, height )
  if isCursorShowing( ) then
    local mouseX, mouseY = getCursorPosition( )
    local clientW, clientH = guiGetScreenSize( )
    local mouseX, mouseY = mouseX * clientW, mouseY * clientH
    if ( mouseX > posX and mouseX < ( posX + width ) and mouseY > posY and mouseY < ( posY + height ) ) then
      return true
    end
  end
  return false
end

-- //#FPS
local counter = 0
local starttick
local currenttick

addEventHandler("onClientRender", getRootElement(),
	function()
		if not starttick then
			starttick = getTickCount()
		end
		counter = counter + 1
		currenttick = getTickCount()
		if currenttick - starttick >= 1000 then
			setElementData(getLocalPlayer(), "FPS", counter,false)
			counter = 0
			starttick = false
		end
	end
)

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
local MoneyW, MoneyH = respc(235), respc(30)
local MoneyX, MoneyY = screenX - MoneyW, respc(120)
function RenderManMoney( amount)
    --local temp_money = getPlayerMoney(player)
    if tonumber(amount) > 0 then
        --setPlayerMoney(player,(temp_money-amount))
        MainpulatedMoney = "#9e0b0b- " .. formatMoney(math.abs(amount), ".")
    elseif tonumber(amount) < 0 then
        --setPlayerMoney(player,(temp_money+amount))
        MainpulatedMoney = "#11ab05+ " .. formatMoney(math.abs(amount), ".")
    else
        MainpulatedMoney = 0
    end
    AlphaAnim = {getTickCount(), 0, 1}
    ---MoneyAnim = {getTickCount(), 0, 1}
    addEventHandler("onClientRender", root, RenderMoney)
    setTimer(
        function()
            removeEventHandler("onClientRender", root, RenderMoney)
            AlphaAnim = false
        end,
        2500,
        1
    )
end

function RenderMoney()
    if AlphaAnim then
        local now = getTickCount()

        local alphaprog = (now - AlphaAnim[1]) / 250
        alpha = interpolateBetween(AlphaAnim[2], 0, 0, AlphaAnim[3], 0, 0, alphaprog, "Linear")
    end
    dxDrawText(
        MainpulatedMoney .. "$",
        MoneyX,
        MoneyY+respc(50),
        MoneyX + MoneyW - respc(15),
        MoneyH,
        tocolor(255, 255, 255, 255 * alpha),
        .95,
        font,
        "right",
        "top",
        false,
        false,
        false,
        true
    )
end




addEventHandler("onClientElementDataChange",localPlayer,function(key,old,new)
	if key == "money" then 
		diff = math.abs(old)-math.abs(new)
		RenderManMoney(diff)
		playSound("effect.mp3")
	end
end)


flyingState = false
local flyingState = false
local keys = {}
keys.up = "up"
keys.down = "up"
keys.f = "up"
keys.b = "up"
keys.l = "up"
keys.r = "up"
keys.a = "up"
keys.s = "up"
keys.m = "up"

function toggleFly()
    flyingState = not flyingState   
    if flyingState then
        addEventHandler("onClientRender",getRootElement(),flyingRender, true, "low-5")
        bindKey("lshift","both",keyH)
        bindKey("rshift","both",keyH)
        bindKey("lctrl","both",keyH)
        bindKey("rctrl","both",keyH)
        
        bindKey("forwards","both",keyH)
        bindKey("backwards","both",keyH)
        bindKey("left","both",keyH)
        bindKey("right","both",keyH)
        
        bindKey("lalt","both",keyH)
        bindKey("space","both",keyH)
        bindKey("ralt","both",keyH)
        bindKey("mouse1","both",keyH)
        setElementCollisionsEnabled(getLocalPlayer(),false)
        setElementData(localPlayer, "keysDenied", true)
        --setElementData(localPlayer, "fly", true)
        --triggerServerEvent("ac.elementData",localPlayer,localPlayer,"fly",true);
    else
        removeEventHandler("onClientRender",getRootElement(),flyingRender)
        unbindKey("mouse1","both",keyH)
        unbindKey("lshift","both",keyH)
        unbindKey("rshift","both",keyH)
        unbindKey("lctrl","both",keyH)
        unbindKey("rctrl","both",keyH)
        
        unbindKey("forwards","both",keyH)
        unbindKey("backwards","both",keyH)
        unbindKey("left","both",keyH)
        unbindKey("right","both",keyH)
        
        unbindKey("space","both",keyH)
        
        keys.up = "up"
        keys.down = "up"
        keys.f = "up"
        keys.b = "up"
        keys.l = "up"
        keys.r = "up"
        keys.a = "up"
        keys.s = "up"
        setElementCollisionsEnabled(getLocalPlayer(),true)
        setElementData(localPlayer, "keysDenied", false)
        --setElementData(localPlayer, "fly", false)
        --triggerServerEvent("ac.elementData",localPlayer,localPlayer,"fly",false);
    end
end

function flyingRender()
    local x,y,z = getElementPosition(getLocalPlayer())
    local speed = 10
    if keys.a=="down" then
        speed = 3
    elseif keys.s=="down" then
        speed = 50
    elseif keys.m=="down" then
        speed = 300
    end
    
    if keys.f=="down" then
        local a = rotFromCam(0)
        setElementRotation(getLocalPlayer(),0,0,a)
        local ox,oy = dirMove(a)
        x = x + ox * 0.1 * speed
        y = y + oy * 0.1 * speed
    elseif keys.b=="down" then
        local a = rotFromCam(180)
        setElementRotation(getLocalPlayer(),0,0,a)
        local ox,oy = dirMove(a)
        x = x + ox * 0.1 * speed
        y = y + oy * 0.1 * speed
    end
    
    if keys.l=="down" then
        local a = rotFromCam(-90)
        setElementRotation(getLocalPlayer(),0,0,a)
        local ox,oy = dirMove(a)
        x = x + ox * 0.1 * speed
        y = y + oy * 0.1 * speed
    elseif keys.r=="down" then
        local a = rotFromCam(90)
        setElementRotation(getLocalPlayer(),0,0,a)
        local ox,oy = dirMove(a)
        x = x + ox * 0.1 * speed
        y = y + oy * 0.1 * speed
    end
    
    if keys.up=="down" then
        z = z + 0.1*speed
    elseif keys.down=="down" then
        z = z - 0.1*speed
    end
    
    setElementPosition(getLocalPlayer(),x,y,z)
end

function keyH(key,state)
    if key=="lshift" or key=="rshift" then
        keys.s = state
    end 
    if key=="lctrl" or key=="rctrl" then
        keys.down = state
    end 
    if key=="forwards" then
        keys.f = state
    end 
    if key=="backwards" then
        keys.b = state
    end 
    if key=="left" then
        keys.l = state
    end 
    if key=="right" then
        keys.r = state
    end 
    if key=="lalt" or key=="ralt" then
        keys.a = state
    end 
    if key=="space" then
        keys.up = state
    end 
    if key=="mouse1" then
        keys.m = state
    end 
end

function rotFromCam(rzOffset)
    local cx,cy,_,fx,fy = getCameraMatrix(getLocalPlayer())
    local deltaY,deltaX = fy-cy,fx-cx
    local rotZ = math.deg(math.atan((deltaY)/(deltaX)))
    if deltaY >= 0 and deltaX <= 0 then
        rotZ = rotZ+180
    elseif deltaY <= 0 and deltaX <= 0 then
        rotZ = rotZ+180
    end
    return -rotZ+90 + rzOffset
end

function dirMove(a)
    local x = math.sin(math.rad(a))
    local y = math.cos(math.rad(a))
    return x,y
end

addEventHandler("onClientElementDataChange", localPlayer,
    function(dName)
        if dName == "keysDenied" and flyingState then
            local value = getElementData(source, dName)
            if not value then
                setElementData(source, dName, true)
            end
end
    end
)
addCommandHandler("fly",toggleFly)