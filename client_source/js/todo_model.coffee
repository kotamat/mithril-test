m = require 'mithril'

Todo = (data) ->
    @description = m.prop data and data.description or ''
    @done = m.prop false
    return

Todo.list = ->
    m.request
        method: 'GET'
        url: '/tasks'
        type: Todo

Todo.save = (todoList) ->
    m.request
        method: 'POST'
        url: '/tasks'
        data: todoList

module.exports = Todo
