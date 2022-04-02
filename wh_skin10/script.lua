-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'bfyri.txd' ) 
engineImportTXD( txd, 21 ) 
dff = engineLoadDFF('bfyri.dff', 21) 
engineReplaceModel( dff, 21 )
end)
