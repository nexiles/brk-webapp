Ext.application
  requires: ['Ext.container.Container']
  controllers: ["Main"]
  name: 'BRK-Webapp'

  launch: ->
    Ext.create 'Ext.container.Viewport'
      closable: false
      layout: {
      type: 'vbox'
      align: 'stretch'
      }

      renderTo: Ext.getBody()
      items: [
        {
          xtype: 'applist'
          flex: 1
        }
        {
          xtype: 'apppreview'
          title: "Preview"
          resizable : true
          autoScroll: true
          height: 300
        }
      ]
