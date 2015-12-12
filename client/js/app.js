var Todo, controller, view, vm;

Todo = function(data) {
  this.description = m.prop(data.description);
  this.done = m.prop(false);
};

Todo.list = function() {
  var json, src, task, tasks;
  tasks = [];
  src = localStorage.getItem('todo');
  if (src) {
    json = JSON.parse(src);
    tasks = (function() {
      var i, len, results;
      results = [];
      for (i = 0, len = json.length; i < len; i++) {
        task = json[i];
        results.push(new Todo(task));
      }
      return results;
    })();
  }
  return m.prop(tasks);
};

Todo.save = function(todoList) {
  return localStorage.setItem('todo', JSON.stringify(todoList.filter(function(todo) {
    return !todo.done();
  })));
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
