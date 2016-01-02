m = require 'mithril'

titleModule =
    controller: ->
    view: ->
        m '.container.theme-showcase', [
            m '.jumbotron', [
                m('h1', 'theme example'),
                m 'p', 'This is a template showcasing the optional' +
                    'theme stylesheet included in bootstrap'
            ]
        ]

module.exports = HomePage
