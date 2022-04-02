function playerChat(message, messageType)
    print(messageType)
    cancelEvent()
    if isPedDead(source) then return end
    if messageType == 0 then 
        local x,y,z = getElementPosition(source)
        for _,player in pairs(getElementsByType("player")) do 
            local px,py,pz = getElementPosition(player)
            if getDistanceBetweenPoints3D(x,y,z,px,py,pz) < 6 then 
                triggerClientEvent(source,"sendMessageToClient",player,source,message,"#ffffff")
            end
        end
    end
end
addEventHandler("onPlayerChat", root, playerChat)
    

function AdminChat(source,cmd,...)
    if not getElementData(source,"adminlevel") or 0 > 0 then return end
    if not ... then outputChatBox("[#e35f23White TDMA #ffffff-#e35f23 Chat#ffffff] /a [szöveg]",source,255,255,255,true) return end
    local text = table.concat({...}," ")
    if string.len(text) < 3 then         
        return 
    end
    local x,y,z = getElementPosition(source)
    for _,player in pairs(getElementsByType("player")) do 
        if tonumber(getElementData(player,"adminlevel") or 0) > 0 then 
            triggerClientEvent(player,"sendAdminChatToEveryone",player,source,text)
        end
    end
end
addCommandHandler("a",AdminChat,false,false)
addCommandHandler("achat",AdminChat,false,false)

function AdminSChat(source,cmd,...)
    if not ((getElementData(source,"adminlevel") or 0) == -1) or not (getElementData(source,"adminlevel") or 0 > 0) then return end
    if not ... then outputChatBox("[#e35f23White TDMA #ffffff-#e35f23 Chat#ffffff] /as [szöveg]",source,255,255,255,true) return end
    local text = table.concat({...}," ")
    if string.len(text) < 3 then         
        return 
    end
    for _,player in pairs(getElementsByType("player")) do 
        if tonumber(getElementData(player,"adminlevel") or 0) == -1 or tonumber(getElementData(player,"adminlevel") or 0) > 0 then 
            triggerClientEvent(player,"sendAdminSChatToEveryone",player,source,text)
        end
    end
end
addCommandHandler("as",AdminSChat,false,false)

function ASAY(source,cmd,...)
    if not (getElementData(source,"adminlevel") or 0 > 1) then return end
    
    if not ... then outputChatBox("[#e35f23White TDMA #ffffff-#e35f23 Chat#ffffff] /asay [szöveg]",source,255,255,255,true) return end
    local text = table.concat({...}," ")
    if string.len(text) < 3 then         
        return 
    end
    outputChatBox(exports["sos_admin"]:GetAdminSyntax(source)..": "..text.."#ffffff",root, 255, 255, 255,true)
end
addCommandHandler("asay",ASAY,false,false)