Todo = (data) ->
    @description = m.prop data.description
    @done = m.prop false
    return

Todo.list = ->
    tasks = []
    src = localStorage.getItem 'todo'
    if src
        json = JSON.parse src
        tasks = for task in json
          new Todo task
    m.prop tasks

Todo.save = (todoList) ->
    localStorage.setItem 'todo',
        JSON.stringify todoList.filter (todo) ->
            !todo.done()

vm =
    init: ->
        vm.list = Todo.list()
        vm.description = m.prop ""
        vm.add = ->
            if vm.description()
                vm.list().push new Todo
                    description: vm.description()
                vm.description ""
                Todo.save vm.list()
        vm.check = (value) ->
            @done value
            Todo.save vm.list()

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
                        onclick: m.withAttr 'checked', vm.check.bind task
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
