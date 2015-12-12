myModel = ->
    instance = null
    model = ->
        this.name = 'name'
        this.email = 'email.com'
        return

    model.get = ->
        instance = m.prop new myModel() if instance?

    return model

vm =
    init: ->
        vm.model = myModel().get()

myComponent =
    controller: ->
        vm.init()
    view: (controller) ->
        m 'h1', vm.model().name

m.mount document.getElementById('root'), myComponent
