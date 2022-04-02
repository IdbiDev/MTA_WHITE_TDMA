-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'BySampaio.txd' ) 
engineImportTXD( txd, 11 ) 
dff = engineLoadDFF('BySampaio.dff', 11) 
engineReplaceModel( dff, 11 )
end)
