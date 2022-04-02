-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'BySampaio.txd' ) 
engineImportTXD( txd, 12 ) 
dff = engineLoadDFF('BySampaio.dff', 12) 
engineReplaceModel( dff, 12 )
end)
