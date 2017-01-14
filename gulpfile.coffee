gulp    = require 'gulp'
concat  = require 'gulp-concat'
coffee  = require 'gulp-coffee'
umd     = require 'gulp-umd-wrap'
plumber = require 'gulp-plumber'
fs      = require 'fs'

gulp.task 'default', ['build', 'watch'], ->

gulp.task 'build', ->
  dependencies = [{global: 'document', native:  true},
                  {global: '$',        require: 'jquery'}]
  header = fs.readFileSync('source/__license__.coffee')
  gulp.src('source/jquery-animation.coffee')
    .pipe plumber()
    .pipe umd({dependencies, header})
    .pipe concat('jquery-animation.coffee')
    .pipe gulp.dest('build')
    .pipe coffee()
    .pipe concat('jquery-animation.js')
    .pipe gulp.dest('build')

gulp.task 'watch', ->
  gulp.watch 'source/**/*', ['build']
