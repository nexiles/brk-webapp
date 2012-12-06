eventtype = "reports"

Ext.define 'BRK-Webapp.view.appui'
  extend: 'Ext.grid.Panel'
  alias: 'widget.applist'

  store: 'apps'
  cls: 'feed-grid'


  tbar: [
    Ext.create 'Ext.Button'
      text: "Aktuell"
      listeners:
        click:
          element: 'el'
          fn: ->
            mystore = Ext.StoreManager.getAt(1)
            mystore.proxy.url = "http://www.brk.de/@@API/"+eventtype
            mystore.load()
            Ext.getCmp("search").setValue("")

    Ext.create 'Ext.form.field.Text'
      id: "search"
      width: 200
      # listeners:
      #   keyup:
      #     element: 'el'
      #     fn: ->
      #       mystore = Ext.StoreManager.getAt(1)
      #       value = Ext.getCmp("search").getValue()
      #       console.log value;
      #       if(value.length > 3)
      #         mystore.proxy.url = "http://www.brk.de/@@API/"+eventtype+"?q="+value
      #         mystore.load()

    Ext.create 'Ext.Button'
      text: "Suchen"
      listeners:
        click:
          element: 'el'
          fn: ->
            mystore = Ext.StoreManager.getAt(1)
            searchvalue = Ext.getCmp("search").getValue()
            if(searchvalue != "")
              mystore.proxy.url = "http://www.brk.de/@@API/"+eventtype+"?q="+searchvalue
            else
              mystore.proxy.url = "http://www.brk.de/@@API/"+eventtype
            mystore.load()

    Ext.create 'Ext.form.field.Radio'
      boxLabel  : 'Berichte'
      value: "reports"
      name: 'type'
      checked: true
      listeners:
        change:(select, newValue, oldValue) ->
          if(newValue == true)
            eventtype = "reports"
            mystore = Ext.StoreManager.getAt(1)
            searchvalue = Ext.getCmp("search").getValue()
            if(searchvalue != "")
              mystore.proxy.url = "http://www.brk.de/@@API/"+eventtype+"?q="+searchvalue
            else
              mystore.proxy.url = "http://www.brk.de/@@API/"+eventtype
            mystore.load()


    Ext.create 'Ext.form.field.Radio'
      boxLabel  : 'Veranstaltungen'
      value: "events"
      name: 'type'
      listeners:
        change:(select, newValue, oldValue) ->
          if(newValue == true)
            eventtype = "events"
            mystore = Ext.StoreManager.getAt(1)
            searchvalue = Ext.getCmp("search").getValue()
            if(searchvalue != "")
              mystore.proxy.url = "http://www.brk.de/@@API/"+eventtype+"?q="+searchvalue
            else
              mystore.proxy.url = "http://www.brk.de/@@API/"+eventtype
            mystore.load()
  ]

  initComponent: ->

    Ext.apply @,
      columns: [
      	{
          text: 'Title'
          dataIndex: 'title'
          renderer: @formatTitle
          flex: 1
      	}
      	{
          text: 'Beschreibung'
          dataIndex: 'description'
          hidden: true
          width: 200
      	}
      	{
          text: 'Date'
          dataIndex: 'effective'
          renderer: @fDate
          width: 200
      	}
      ]
    @callParent(arguments)


  formatTitle: (value, p, record) ->
    return Ext.String.format('<div class="topic"><b>{0}</b><br><span class="description">{1}</span></div>', value, record.get('description') || "")

  fDate: (value, p, record)->
    return Ext.String.format("{0}",prettyDate(value))
