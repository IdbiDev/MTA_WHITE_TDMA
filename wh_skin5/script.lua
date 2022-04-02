-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'ByFlashStore.txd' ) 
engineImportTXD( txd, 16 ) 
dff = engineLoadDFF('ByFlashStore.dff', 16) 
engineReplaceModel( dff, 16 )
end)
