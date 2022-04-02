txd = engineLoadTXD( 'ByPimentinha.txd' )
engineImportTXD( txd, 31 )
dff = engineLoadDFF('ByPimentinha.dff', 31)
engineReplaceModel( dff, 31 )