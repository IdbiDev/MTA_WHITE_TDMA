function replaceModel() 
  txd = engineLoadTXD("Data/ak47.txd", 355 )
  engineImportTXD(txd, 355)
  dff = engineLoadDFF("Data/ak47.dff", 355 )
  engineReplaceModel(dff, 355)

  txd = engineLoadTXD("Data/chromegun.txd", 351 )
  engineImportTXD(txd, 351)
  dff = engineLoadDFF("Data/chromegun.dff", 351 )
  engineReplaceModel(dff, 351)

  txd = engineLoadTXD("Data/colt45.txd", 346 )
  engineImportTXD(txd, 346)
  dff = engineLoadDFF("Data/colt45.dff", 346 )
  engineReplaceModel(dff, 346)

  txd = engineLoadTXD("Data/cuntgun.txd", 357 )
  engineImportTXD(txd, 357)
  dff = engineLoadDFF("Data/cuntgun.dff", 357 )
  engineReplaceModel(dff, 357)

  txd = engineLoadTXD("Data/desert_eagle.txd", 348 )
  engineImportTXD(txd, 348)
  dff = engineLoadDFF("Data/desert_eagle.dff", 348 )
  engineReplaceModel(dff, 348)

  txd = engineLoadTXD("Data/grenade.txd", 342 )
  engineImportTXD(txd, 342)
  dff = engineLoadDFF("Data/grenade.dff", 342 )
  engineReplaceModel(dff, 342)

  txd = engineLoadTXD("Data/knifecur.txd", 335 )
  engineImportTXD(txd, 335)
  dff = engineLoadDFF("Data/knifecur.dff", 335 )
  engineReplaceModel(dff, 335)

  txd = engineLoadTXD("Data/m4.txd", 356 )
  engineImportTXD(txd, 356)
  dff = engineLoadDFF("Data/m4.dff", 356 )
  engineReplaceModel(dff, 356)

  txd = engineLoadTXD("Data/micro_uzi.txd", 352 )
  engineImportTXD(txd, 352)
  dff = engineLoadDFF("Data/micro_uzi.dff", 352 )
  engineReplaceModel(dff, 352)

  txd = engineLoadTXD("Data/mp5lng.txd", 353 )
  engineImportTXD(txd, 353)
  dff = engineLoadDFF("Data/mp5lng.dff", 353 )
  engineReplaceModel(dff, 353)

  txd = engineLoadTXD("Data/sawnoff.txd", 350 )
  engineImportTXD(txd, 350)
  dff = engineLoadDFF("Data/sawnoff.dff", 350 )
  engineReplaceModel(dff, 350)

  txd = engineLoadTXD("Data/shotgspa.txd", 349 )
  engineImportTXD(txd, 349)
  dff = engineLoadDFF("Data/shotgspa.dff", 349 )
  engineReplaceModel(dff, 349)

  txd = engineLoadTXD("Data/silenced.txd", 347 )
  engineImportTXD(txd, 347)
  dff = engineLoadDFF("Data/silenced.dff", 347 )
  engineReplaceModel(dff, 347)
  
  txd = engineLoadTXD("Data/sniper.txd", 358 )
  engineImportTXD(txd, 358)
  dff = engineLoadDFF("Data/sniper.dff", 358 )
  engineReplaceModel(dff, 358)

  txd = engineLoadTXD("Data/teargas.txd", 343 )
  engineImportTXD(txd, 343)
  dff = engineLoadDFF("Data/teargas.dff", 343 )
  engineReplaceModel(dff, 343)

  txd = engineLoadTXD("Data/tec9.txd", 372 )
  engineImportTXD(txd, 372)
  dff = engineLoadDFF("Data/tec9.dff", 372 )
  engineReplaceModel(dff, 372)
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), replaceModel)