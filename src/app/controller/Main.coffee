Ext.define 'BRK-Webapp.controller.Main'
  extend: 'Ext.app.Controller'
  views:  ['appui','apppreview']
  stores: ['apps','appcontent']
  models: ['app','appmod']

  refs: [
    {ref: 'appPreview',selector: 'apppreview'}
  ]

  init: ->
  	@control
    	'applist': 
      	itemclick: @previewArticle
    window.test = @

  previewArticle: (grid, record) ->
    mystore = @getAppcontentStore()
    mystore.proxy.url = record.data.api_url
    mystore.load()