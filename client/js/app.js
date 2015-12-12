var Todo, controller, view, vm;

Todo = function(data) {
  this.description = m.prop(data.description);
  this.done = m.prop(false);
};

Todo.list = function() {
  return m.request({
    method: 'GET',
    url: '/tasks',
    type: Todo
  });
};

Todo.save = function(todoList) {
  var data;
  data = todoList.filter(function(todo) {
    return !todo.done();
  });
  return m.request({
    method: 'POST',
    url: '/tasks',
    data: data
  });
};

vm = {
  init: function() {
    vm.list = Todo.list();
    vm.description = m.prop("");
    vm.add = function() {
      if (vm.description()) {
        vm.list().push(new Todo({
          description: vm.description()
        }));
        vm.description("");
        return Todo.save(vm.list());
      }
    };
    return vm.check = function(value) {
      this.done(value);
      return Todo.save(vm.list());
    };
  }
};

controller = function() {
  return vm.init();
};

view = function() {
  return m('div', [
    m("input", {
      onchange: m.withAttr("value", vm.description),
      value: vm.description()
    }), m("button", {
      onclick: vm.add
    }, "追加"), m('table', vm.list().map(function(task) {
      return m('tr', [
        m('td', [
          m('input[type=checkbox]', {
            onclick: m.withAttr('checked', vm.check.bind(task)),
            value: task.done()
          })
        ]), m('td', {
          style: {
            textDecoration: task.done() ? 'line-through' : "none"
          }
        }, task.description())
      ]);
    }))
  ]);
};

m.mount(document.getElementById('root'), {
  controller: controller,
  view: view
});

//# sourceMappingURL=app.js.map
