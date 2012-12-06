Ext.define 'BRK-Webapp.view.apppreview'
  extend: 'Ext.panel.Panel'
  alias: 'widget.apppreview'
  store: 'appcontent'
  cls: 'preview'

  initComponent: ->

    template = """
    <tpl for=".">
      <tpl if="start_date == ''">
        <tpl if="text !=''">
          <h1>{title}</h1>
            <div id="report_content">
            <div class="discreet">Veröffentlicht {modified}</div>
              <div style="clear:both;float:left;padding:1em;">
                <table cellspacing="0" cellpadding="0" border="0" width="1">
                  <tbody><tr>
                    <td>
                      <tpl if="image1 != ''">              
                        <a href="{image1}" target="_blank">
                        <img src="{image1}_mini" alt="{title}" title="{title}" width="200px">
                        </a>
                      <tpl else>
                        <img src="{thumbnail}" alt="{title}" title="{title}" width="200px">
                      </tpl>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <div style="font-style:italic"><tpl if="image1 != ''">{image1_text}</tpl></div>
                    </td>
                  </tr>
                </tbody>
                </table>
              </div>
              <p>
                {text}
              </p>      
          <div style="clear:both;"></div>
          </div>
        </tpl>
      <tpl else>
        <h1>{title}</h1>
        <table>
          <tr><td width="50px">Was</td><td>{title}  {description}</td></tr>
          <tr><td>Wann </td><td>{event_date}</td></tr>
          <tr><td>Wo</td><td>{event_area}<tpl if="location != ''">, </tpl>{location}</td></tr>
        </table>
        <tpl if="text !=''">
          {text}
        </tpl>
      </tpl>
    </tpl>
    """
         
    @items = [
      Ext.create 'Ext.view.View'
        store: Ext.data.StoreManager.lookup('appcontent')
        id: 'reports'
        itemSelector: 'div.thumb-wrap'
        tpl: [template]
        prepareData: (data) =>
          Ext.apply data,
            modified: @time data.modified
            event_date: @event_date data.start_date,data.end_date
            event_area: @getarea data.url
          return data
    ]
    @callParent()

  getarea: (url)->
    parser = document.createElement('a')
    parser.href = url
    path = parser.pathname
    folder = path.split("/")
    return folder[1]+", "+folder[2]



  pretext: (data)->
    daten = data.replace(/<p>\s<\/p>/g,"")
    return daten

  event_date: (start, end)->
    start_d = new Date(start)
    start_month = start_d.getMonth() + 1
    start_day = start_d.getDate()
    start_year = start_d.getFullYear()
    start_date = start_day+"."+start_month+"."+start_year
    start_hours = start_d.getHours()
    start_minutes = start_d.getMinutes()
    if (start_minutes < 10)
      start_minutes = "0" + start_minutes
    start_time = start_hours+":"+start_minutes

    end_d = new Date(end)
    end_month = end_d.getMonth() + 1
    end_day = end_d.getDate()
    end_year = end_d.getFullYear()
    end_date = end_day+"."+end_month+"."+end_year
    end_hours = end_d.getHours()
    end_minutes = end_d.getMinutes()
    if (end_minutes < 10)
      end_minutes = "0" + end_minutes
    end_time = end_hours+":"+end_minutes

    if(end_date == start_date)
      output =  start_date+" "+start_time+" Uhr - "+end_time+" Uhr"
    else
      output =  start_date+" "+start_time+" Uhr - "+ end_date+" "+end_time+" Uhr"

    return output

  time: (data)->
    return prettyDate(data)