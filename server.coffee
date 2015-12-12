m = require './client/js/mithril.min.js'
render = require 'mithril-node-render'

console.log render m 'div', '<button onclick=\'alert("hello");\'>test</button>'
