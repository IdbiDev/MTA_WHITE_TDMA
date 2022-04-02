-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'ByScoobiy.txd' ) 
engineImportTXD( txd, 22 ) 
dff = engineLoadDFF('byScoobiy.dff', 22) 
engineReplaceModel( dff, 22 )
end)
