gulp        = require 'gulp'
path        = require 'path'
jade        = require 'gulp-jade'
concat      = require 'gulp-concat'
del         = require 'del'
minifycss   = require 'gulp-minify-css'
watch       = require 'gulp-watch'
rename      = require 'gulp-rename'
less        = require 'gulp-less'
coffee      = require 'gulp-coffee'
plumber     = require 'gulp-plumber'
annotate    = require 'gulp-ng-annotate'
prefix      = require 'gulp-autoprefixer'
remember    = require 'gulp-remember'
cached      = require 'gulp-cached'
browserSync = require 'browser-sync'
runSequence = require 'run-sequence'
lbsdk       = require('gulp-loopback-sdk-angular')

# -------------------------------------------
# Setup
# -------------------------------------------

folders     =
  app       : "app"
  dist      : "dist"
  styles    : "app/styles"
  assets    : "app/assets"

sources     =
  appSrc    : path.join folders.app, "app.coffee"
  coffeeSrc : path.join folders.app, "**/*.coffee"
  jadeSrc   : path.join folders.app, "**/*.jade"

  assetsSrc : path.join folders.assets, "**/*"
  lessSrc   : path.join folders.styles, "**/*.less"
  styleSrc  : path.join folders.styles, "styles.less"

destinations =
  base      : folders.dist
  externals : path.join folders.dist, "externals"

reload      = browserSync.reload
serverPort  = 3000

# -------------------------------------------
# Compile Jade to HTML
# -------------------------------------------
markupPipes = (source) ->
  source
    .pipe plumber()
    .pipe jade()
    .pipe gulp.dest destinations.base
    .pipe reload stream: true

# -------------------------------------------
# Compile Scripts
# -------------------------------------------
scriptPipes = ->
  gulp
    .src [
      sources.appSrc
      sources.coffeeSrc
      # Ignored files
      '!./app/karma.conf.coffee'
      '!./app/**/*.spec.coffee'
    ]
    .pipe plumber()
    .pipe cached()
    .pipe coffee( bare: true ).on('error', console.log)
    .pipe annotate()
    .pipe gulp.dest destinations.base
    .pipe remember()
    .pipe concat 'app.js'
    .pipe gulp.dest destinations.base
    .pipe reload stream: true

# -------------------------------------------
# Compile Styles
# -------------------------------------------
stylePipes = ->
  gulp
    .src [sources.styleSrc]
    .pipe plumber()
    .pipe less()
    .pipe prefix()
    .pipe gulp.dest destinations.base
    .pipe rename
      suffix: '.min'
    .pipe minifycss()
    .pipe gulp.dest destinations.base
    .pipe reload stream: true

# -------------------------------------------
# Compile SDK
# -------------------------------------------
lbServices = ->
  gulp
    .src "./server/server.js"
    .pipe lbsdk()
    .pipe rename "lb-services.js"
    .pipe gulp.dest destinations.externals

# -------------------------------------------
# Gulp Tasks
# -------------------------------------------

# Scripts
gulp.task 'scripts', scriptPipes

# Karma File
gulp.task 'karma-coffee-script', ->
  gulp
    .src path.join folders.app, 'karma.conf.coffee'
    .pipe plumber()
    .pipe coffee({bare: true}).on('error', console.log)
    .pipe gulp.dest destinations.base

# Jade
gulp.task 'jade', -> markupPipes gulp.src sources.jadeSrc

# Styles
gulp.task 'styles', stylePipes

# SDK
gulp.task "lbServices", lbServices

# External Libs
gulp.task "externals", ->
  gulp
    .src [
      "bower_components/angular/angular.min.js"
      "bower_components/angular/angular.min.js.map"
      "bower_components/angular-animate/angular-animate.min.js"
      "bower_components/angular-animate/angular-animate.min.js.map"
      "bower_components/angular-ui-router/release/angular-ui-router.min.js"
      "bower_components/angular-sanitize/angular-sanitize.min.js"
      "bower_components/angular-sanitize/angular-sanitize.min.js.map"
      "bower_components/angular-hotkeys/build/hotkeys.min.js"
      "bower_components/angular-cookies/angular-cookies.min.js"
      "bower_components/angular-cookies/angular-cookies.min.js.map"
      "bower_components/angular-resource/angular-resource.min.js"
      "bower_components/angular-resource/angular-resource.min.js.map"
      "bower_components/ngmap/build/scripts/ng-map.min.js"
      "app/externals/lb-services.js"
      "app/externals/gmap.js"
    ]
    .pipe gulp.dest destinations.externals

# Assets
gulp.task 'assets', ->
  gulp
    .src sources.assetsSrc
    .pipe gulp.dest destinations.base

# -------------------------------------------
# Watch
# -------------------------------------------

# Compile
gulp.task 'watch:compile', ->
  watch sources.jadeSrc, (files) ->
    markupPipes( gulp.src sources.jadeSrc )

  watch sources.coffeeSrc, scriptPipes
  watch sources.lessSrc, stylePipes
  return

# BrowserSync
gulp.task 'serverSync', ->
  browserSync
    server:
      baseDir: destinations.base
    port: serverPort
    notify: true
    open: false
  return

# -------------------------------------------
# Clean
# -------------------------------------------
gulp.task 'clean', ->
  del destinations.base

# -------------------------------------------
# Build
# -------------------------------------------
gulp.task 'build', ['assets', 'externals', 'scripts', 'karma-coffee-script', 'jade', 'styles']

gulp.task 'dist', ['clean'], ->  gulp.start 'build'

gulp.task 'serverlocal', ->
  runSequence(
    'clean',
    'build',
    'serverSync',
    'watch:compile'
  )
