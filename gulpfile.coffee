gulp = require 'gulp'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
plumber = require 'gulp-plumber'
sass = require 'gulp-sass'
sourcemaps = require 'gulp-sourcemaps'
livereload = require 'gulp-livereload'
express = require 'express'
fs = require 'fs'
bodyParser = require 'body-parser'

app = express()


files =
    coffee: './client/js/*.coffee'
    scss  : './client/css/*.scss'

gulp.task 'reload', ->
    gulp.src ['client/*/*']
    .pipe livereload()

gulp.task 'js', ->
    gulp.src files.coffee
        .pipe plumber()
        .pipe sourcemaps.init
            loadMaps: true
        .pipe coffee
            bare: true
        .pipe concat 'app.js'
        .pipe sourcemaps.write '.',
            addComment: true
            sourceRoot: '/src'
        .pipe gulp.dest './client/js'


gulp.task 'css', ->
    gulp.src files.scss
        .pipe plumber()
        .pipe sass()
        .pipe gulp.dest './client/css'


gulp.task 'watch', ['build'], ->
    gulp.watch files.coffee, ['js']
    gulp.watch files.scss, ['css']

    gulp.watch ['client/**/*'], ['reload']
    livereload.listen()

gulp.task 'server', ->
    app.use bodyParser.json()
    app.get '/tasks', (req, res) ->
        console.log 'get tasks'
        try
            res.send JSON.parse fs.readFileSync 'todo.json', 'utf8'
        catch error
            res.send []
    app.post '/tasks', (req, res) ->
        console.log 'post tasks'
        fs.writeFileSync 'todo.json', JSON.stringify req.body
        res.status 200
            .end()

    app.use express.static 'client'
    console.log 'start listening at 8000'
    app.listen 8000


gulp.task 'build', ['js', 'css']
gulp.task 'default', ['build']
