App.events = App.cable.subscriptions.create "EventsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log 'connected'

  disconnected: ->
    # Called when the subscription has been terminated by the server
    console.log 'disconnected'

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    events = $('#events')
    content = "<div id='event_"
    content += data['id'] + "'>"
    content += data['created_at']+","
    content += data['name']+","
    content += data['action']+","
    content += data["title"]
    content += "</div>"
    events.prepend content
    console.log 'received'

