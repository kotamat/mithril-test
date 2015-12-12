home =
    controller: ->
    view: ->
        m 'h1', 'home'

home.controller.prototype.onunload = (e) ->
    console.log 'home unloaded'

dashboard =
    controller: ->
    view: ->
        m 'h1', 'dashboard'

dashboard.controller.prototype.onunload = (e) ->
    e.preventDefault()

m.route document.body, '/',
    '/': home
    '/dashboard': dashboard

m.route '/dashboard'
m.route '/home'
