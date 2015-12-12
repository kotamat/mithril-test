var dashboard, home;

home = {
  controller: function() {},
  view: function() {
    return m('h1', 'home');
  }
};

home.controller.prototype.onunload = function(e) {
  return console.log('home unloaded');
};

dashboard = {
  controller: function() {},
  view: function() {
    return m('h1', 'dashboard');
  }
};

dashboard.controller.prototype.onunload = function(e) {
  return e.preventDefault();
};

m.route(document.body, '/', {
  '/': home,
  '/dashboard': dashboard
});

m.route('/dashboard');

m.route('/home');

//# sourceMappingURL=app.js.map
