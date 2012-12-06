Ext.define 'BRK-Webapp.store.appcontent'
  extend: 'Ext.data.Store'
  model: 'BRK-Webapp.model.appmod'
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