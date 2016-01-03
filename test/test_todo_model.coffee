Todo = require '../client_source/js/todo_model'
assert = require 'power-assert'
sinon = require 'sinon'
m = require 'mithril'

sinon.xhr.supportsCORS = true

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

describe 'server access', ->
    server = undefined
    beforeEach ->
        server = sinon.fakeServer.create()
        server.respondImmediately = true
        m.deps
            XMLHttpRequest: server.xhr

    afterEach ->
        server.restore()

    it 'can create single object from request', ->
        server.respondWith 'GET', '/tasks', [
            200
            "Content-Type": "application/json"
            JSON.stringify
                description: "横浜に野球の応援に行く"
        ]
        Todo.list().then (obj) ->
            assert obj.description() == "横浜に野球の応援に行く"

    it 'can store objects', ->
        Todo.save [new Todo description: "アンパンマンミュージアムに行く"]
        request = server.requests[0]
        assert request.method == "POST"
        assert request.url == "/tasks"
        json = JSON.parse request.requestBody
        assert json[0].description == "アンパンマンミュージアムに行く"
