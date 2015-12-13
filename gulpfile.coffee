gulp = require 'gulp'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
plumber = require 'gulp-plumber'
sass = require 'gulp-sass'
sourcemaps = require 'gulp-sourcemaps'
livereload = require 'gulp-livereload'
express = require 'express'
browserify = require 'gulp-browserify'

app = express()


files =
    coffee: './client_source/js/*.coffee'
    scss  : './client_source/css/*.scss'
    watch : './client_source/**/*'

gulp.task 'reload', ->
    gulp.src [files.watch]
    .pipe livereload()

gulp.task 'browserify', ->
    gulp.src './client/js/app.js'
    .pipe browserify
        insertGlobals: true,
        debug: !gulp.env.production
    .pipe gulp.dest './client/js/'

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

    gulp.watch files.watch, ['reload']
    livereload.listen()

gulp.task 'server', ->
    app.use express.static 'client'
    app.use express.static 'bower_components'
    console.log 'start listening at 8000'
    app.listen 8000


gulp.task 'build', ['js', 'browserify', 'css']
gulp.task 'default', ['build']
