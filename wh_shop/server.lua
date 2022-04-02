addEvent("onWeaponBuyed",true)
addEventHandler("onWeaponBuyed",root,function(player,data)
    local money = tonumber(getElementData(player,"money") or 0)
    if money-data[2] < 0 then 
        outputChatBox("Nincs elég pénzed!",player,255,10,10,true)
    else 
        setElementData(player,"money",(money-data[2]))
        giveWeapon(player,data[1],9999,true)
        outputChatBox("Sikeresen megvetted a fegyvert!",player,10,255,10,true)
        triggerEvent("RequestSave",player,player)
    end
end)