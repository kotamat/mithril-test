m = require 'mithril'
NavBar = require './navbar'

if document?
    m.mount document.getElementById('navbar'),
        m.component NavBar,
            title: "サンプル一覧"
            root: '/title'
            pages:
                '/title': 'Bootstrapサンプル'
                '/buttons': 'Buttons'
                '/tables': 'Tables'
