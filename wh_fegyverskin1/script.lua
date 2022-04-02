-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'ByKAZIDE.txd' ) 
engineImportTXD( txd, 348 ) 
dff = engineLoadDFF('ByKAZIDE.dff', 348) 
engineReplaceModel( dff, 348 )
end)
