require('gulp-lazyload')
  gulp:       'gulp'
  connect:    'gulp-connect'
  concat:     'gulp-concat'
  coffee:     'gulp-coffee'
  preprocess: 'gulp-preprocess'
  iife:       'gulp-iife-wrap'
  uglify:     'gulp-uglify'
  rename:     'gulp-rename'
  del:        'del'
  plumber:    'gulp-plumber'
  replace:    'gulp-replace'

gulp.task 'default', ['build', 'watch'], ->

dependencies = [
  {require: 'jquery', global: '$'},
  {global: 'document', native: yes}
  {global: 'setTimeout', native: yes}
]

gulp.task 'build', ->
  gulp.src('source/jquery-animation.coffee')
  .pipe plumber()
  .pipe preprocess()
  .pipe iife({dependencies})
  .pipe concat('jquery-animation.coffee')
  .pipe gulp.dest('build')
  .pipe coffee()
  .pipe concat('jquery-animation.js')
  .pipe gulp.dest('build')

gulp.task 'build-min', ['build'], ->
  gulp.src('build/jquery-animation.js')
  .pipe uglify()
  .pipe rename('jquery-animation.min.js')
  .pipe gulp.dest('build')

gulp.task 'watch', ->
  gulp.watch 'source/**/*', ['build']