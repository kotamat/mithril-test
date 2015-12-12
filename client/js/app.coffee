myApplication =
    controller: ->
    view: (controller) ->
        m 'h1', 'hello world'

m.mount document.getElementById('root'), myApplication
