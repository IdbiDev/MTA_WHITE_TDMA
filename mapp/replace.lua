txd = engineLoadTXD("[TMM]BMWM3E46Beast.txd")
engineImportTXD(txd, 562)
dff = engineLoadDFF("[TMM]BMWM3E46Beast.dff", 562)
engineReplaceModel(dff, 562)
