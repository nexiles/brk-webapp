Ext.define 'BRK-Webapp.store.apps'
  extend: 'Ext.data.Store'
  model: 'BRK-Webapp.model.app'
  autoLoad: true
  proxy:
    type: 'jsonp'
    url: 'http://www.brk.de/@@API/reports'
    method: 'GET'
    callbackKey: 'c'
    pageParam: undefined
    startParam: undefined
    extraParams: {limit: 10}
    reader: 
      type: 'json'
      root: 'items'
  groupField: 'effective'
  groupDir: 'DESC'

