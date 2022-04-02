local screenW,screenH = guiGetScreenSize()
local resW, resH = 1366,768
local x, y = (screenW/resW), (screenH/resH)
local components = { "area_name", "radio", "vehicle_name" }
local font = dxCreateFont("font.ttf",20,true)
function DarkzinHud ( ... )
    if (not isPlayerMapVisible()) then

        local weapon = getPedWeapon(getLocalPlayer())
	    local weaponClip = getPedAmmoInClip(getLocalPlayer(), getPedWeaponSlot(getLocalPlayer()))
	    local weaponAmmo = getPedTotalAmmo(getLocalPlayer()) - getPedAmmoInClip(getLocalPlayer())
        local vida = math.floor(getElementHealth(getLocalPlayer()))
        local colete = math.floor(getPedArmor(getLocalPlayer()))
       
        dxDrawImage(screenW * 0.8177, screenH * 0.0130, screenW * 0.1859, screenH * 0.2148, ":Hud/files/Icons/fundo.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(screenW * 0.8507, screenH * 0.0742, screenW * 0.0198, screenH * 0.0313, ":Hud/files/Icons/Vida.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(screenW * 0.8704, screenH * 0.1237, screenW * 0.0242, screenH * 0.0404, ":Hud/files/Icons/Colete.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.8726, screenH * 0.0820, screenW * 0.0688, screenH * 0.0234, tocolor(127, 127, 127, 77), false)
        dxDrawRectangle(screenW * 0.8975, screenH * 0.1367, screenW * 0.0688, screenH * 0.0208, tocolor(127, 127, 127, 77), false)
        dxDrawRectangle(screenW * 0.8726, screenH * 0.0820, screenW * 0.0688/100*vida, screenH * 0.0234, tocolor(253, 0, 0, 254), false)
        dxDrawRectangle(screenW * 0.8975, screenH * 0.1367, screenW * 0.0688/100*colete, screenH * 0.0208, tocolor(34, 38, 71, 254), false)
        dxDrawImage(screenW * 0.6903, screenH * 0.0690, screenW * 0.1310, screenH * 0.1211, ":Hud/files/Icons/Armas/"..weapon..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText(""..weaponClip.."/"..weaponAmmo.."", screenW * 0.7225, screenH * 0.1237, screenW * 0.8507, screenH * 0.1849, tocolor(254, 254, 254, 254), 1.00, "default-bold", "center", "center", false, false, false, false, false)

        dxDrawText(formatMoney(getElementData(localPlayer,"money"),".").."$",screenW * 0.8726, screenH * 0.1820, screenW * 0.0688+screenW * 0.8726, screenH * 0.1820, tocolor(254, 254, 254, 254), 1.00, font, "center", "center", false, false, false, true, false)

    end
end

--/100*fome

function setHud()
    addEventHandler("onClientRender", getRootElement(), DarkzinHud)
    setPlayerHudComponentVisible("armour", false)
    setPlayerHudComponentVisible("wanted", false)
    setPlayerHudComponentVisible("weapon", false)
    setPlayerHudComponentVisible("money", false)
    setPlayerHudComponentVisible("health", false)
    setPlayerHudComponentVisible("clock", false)
    setPlayerHudComponentVisible("breath", false)
    setPlayerHudComponentVisible("ammo", false)

    for _, component in ipairs( components ) do
        setPlayerHudComponentVisible( component, false )
    end
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), setHud)

function removeHud()
    setPlayerHudComponentVisible("armour", true)
    setPlayerHudComponentVisible("wanted", true)
    setPlayerHudComponentVisible("weapon", true)
    setPlayerHudComponentVisible("money", true)
    setPlayerHudComponentVisible("health", true)
    setPlayerHudComponentVisible("clock", true)
    setPlayerHudComponentVisible("breath", true)
    setPlayerHudComponentVisible("ammo", true)
end
addEventHandler("onClientResourceStop", getResourceRootElement(getThisResource()), removeHud)

function formatMoney(amount, stepper)
    local left, center, right = string.match(math.floor(amount), "^([^%d]*%d)(%d*)(.-)$")
    return left .. string.reverse(string.gsub(string.reverse(center), "(%d%d%d)", "%1" .. (stepper or " "))) .. right
end