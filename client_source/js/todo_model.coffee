m = require 'mithril'

Todo = (data) ->
    @description = m.prop data and data.description or ''
    @done = m.prop false
    return

module.exports = Todo
