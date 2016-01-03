m = require 'mithril'

PlaySoundButton =
    controller: ->
        @id = Date.now() + '-' + Math.random()
        @onclick = ->
            document.getElementById(@id).play()
            return
        return
    view: (ctrl, args) ->
        m 'div', [
            m 'audio',
                id: ctrl.id
                [
                    m 'source',
                        src: args.source
                ]
            m 'button',
                onclick: ctrl.onclick.bind ctrl
                args.label
        ]

myApp =
    view: ->
        m 'div',
            m.component PlaySoundButton,
                source: 'https://www.freesound.org/data/previews/201/201902_3710963-lq.mp3'
                label: 'Play'

m.mount document.getElementById('root'), myApp
