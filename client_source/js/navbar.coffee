m = require 'mithril'

NavBar =
    view: (ctrl, args) ->
        activeUrl = m.route()
        return m ".container", [
            m ".navbar-header", [
                m "button.navbar-toggle.collapsed[aria-controls='navbar'][aria-expanded='false'][data-target='#navbar'][data-toggle='collapse'][type='button']", [
                    m("span.sr-only", "Toggle navigation"),
                    m("span.icon-bar"),
                    m("span.icon-bar"),
                    m("span.icon-bar")
                ],
                m "a.navbar-brand", href: '#', config: m.route, args.title
            ],
            m ".collapse.navbar-collapse[id='navbar']", [
                m "ul.nav.navbar-nav", [
                    m "li",
                        class: if args.root == activeUrl then 'active' else ''
                        [m 'a',
                            href: args.root, config: m.route,
                            args.pages[args.root]
                        ]
                    m "li.dropdown", [
                        m "a.dropdown-toggle[aria-expanded='false'][data-toggle='dropdown'][href='#'][role='button']",
                            {
                                class: if args.root == activeUrl then 'active' else ''
                            }
                            [
                                args.title + " ",
                                m 'span.caret'
                            ]
                        m 'ul.dropdown-menu[role="menu"]',
                            Object.keys(args.pages).map (key) ->
                                if key == args.root
                                    return ""
                                m 'li', [
                                    m 'a',
                                        href: key
                                        config: m.route
                                        [
                                            if key == activeUrl then m 'span.glyphicon.glyphicon-triangle-right' else ''
                                            args.pages[key]
                                        ]
                                ]
                    ]
                ]
            ]
        ]

module.exports = NavBar
