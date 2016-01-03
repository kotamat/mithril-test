Todo = require '../client_source/js/todo_model'
assert = require 'power-assert'

describe 'myTodo', ->
    it 'can create instance without option', ->
        todo = new Todo()
        assert todo.description() == ''
        assert todo.done() == false
        return

    it 'can create instance with initial values', ->
        todo = new Todo
            description: 'buy milk'
        assert todo.description() == 'buy milk'
        assert todo.done() == false
        return
