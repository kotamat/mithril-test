var myComponent, myModel, vm;

myModel = function() {
  var instance, model;
  instance = null;
  model = function() {
    this.name = 'name';
    this.email = 'email.com';
  };
  model.get = function() {
    if (instance != null) {
      return instance = m.prop(new myModel());
    }
  };
  return model;
};

vm = {
  init: function() {
    return vm.model = myModel().get();
  }
};

myComponent = {
  controller: function() {
    return vm.init();
  },
  view: function(controller) {
    return m('h1', vm.model().name);
  }
};

m.mount(document.getElementById('root'), myComponent);

//# sourceMappingURL=app.js.map
