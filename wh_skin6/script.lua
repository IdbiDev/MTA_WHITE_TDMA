-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'white.txd' ) 
engineImportTXD( txd, 20 ) 
dff = engineLoadDFF('white.dff', 20) 
engineReplaceModel( dff, 20 )
end)
