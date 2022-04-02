-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'BySampaio.txd' ) 
engineImportTXD( txd, 13 ) 
dff = engineLoadDFF('BySampaio.dff', 13) 
engineReplaceModel( dff, 13 )
end)
