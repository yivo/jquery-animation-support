gulp    = require 'gulp'
concat  = require 'gulp-concat'
coffee  = require 'gulp-coffee'
umd     = require 'gulp-umd-wrap'
plumber = require 'gulp-plumber'
fs      = require 'fs'

gulp.task 'default', ['build', 'watch'], ->

gulp.task 'build', ->
  gulp.src('source/jquery-animation-support.coffee')
    .pipe plumber()
    .pipe umd do ->
            dependencies: [{global: 'document',   native:  true}
                           {global: 'setTimeout', native:  true}
                           {global: '$',          require: 'jquery'}]
            header: fs.readFileSync('source/__license__.coffee')
    .pipe gulp.dest('build')
    .pipe coffee()
    .pipe gulp.dest('build')

gulp.task 'watch', ->
  gulp.watch 'source/**/*', ['build']
