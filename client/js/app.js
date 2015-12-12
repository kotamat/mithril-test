var Todo, controller, view, vm;

Todo = function(data) {
  this.description = m.prop(data.description);
  this.done = m.prop(false);
};

vm = {
  init: function() {
    vm.list = m.prop([]);
    vm.description = m.prop("");
    return vm.add = function() {
      if (vm.description()) {
        vm.list().push(new Todo({
          description: vm.description()
        }));
        return vm.description("");
      }
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
            onclick: m.withAttr('checked', task.done),
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
