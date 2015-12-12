Todo = (data) ->
    @description = m.prop data.description
    @done = m.prop false
    return

vm =
    init: ->
        vm.list = m.prop []
        vm.description = m.prop ""
        vm.add = ->
            if vm.description()
                vm.list().push new Todo
                    description: vm.description()
                vm.description ""

controller = ->
    vm.init()

view = ->
    m 'div', [
        m "input",
            onchange: m.withAttr("value", vm.description)
            value: vm.description()
        m "button",
            onclick: vm.add
            "追加"
        m 'table', vm.list().map (task) ->
            m 'tr', [
                m 'td', [
                    m 'input[type=checkbox]',
                        onclick: m.withAttr 'checked', task.done
                        value: task.done()
                ]
                m 'td',
                    style:
                        textDecoration: if task.done() then 'line-through' else "none"
                    task.description()
            ]
    ]

m.mount document.getElementById('root'),
    controller: controller
    view: view
