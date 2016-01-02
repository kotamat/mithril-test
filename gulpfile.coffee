gulp = require 'gulp'
plumber = require 'gulp-plumber'
sass = require 'gulp-sass'
livereload = require 'gulp-livereload'
express = require 'express'
browserify = require 'browserify'
source = require 'vinyl-source-stream'

app = express()


files =
    coffee: './client_source/js/app.coffee'
    scss  : './client_source/css/*.scss'
    watch : './client_source/**/*'

gulp.task 'reload', ->
    gulp.src ['client/*/*']
    .pipe livereload()

gulp.task 'js', ->
    browserify
        entries: files.coffee
        extensions: ['.coffee', '.js']
    .transform 'coffeeify'
    .bundle()
    .pipe source 'app.js'
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
    app.use express.static 'client'
    console.log 'start listening at 8000'
    app.listen 8000


gulp.task 'build', ['js', 'css']
gulp.task 'default', ['build']
