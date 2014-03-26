"use strict"

module.exports = (grunt) ->
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-sass"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-cssmin"

  grunt.initConfig
    coffee:
      dist:
        files: [
          expand: true
          cwd: "library/coffee"
          src: "{,*/}*.coffee"
          dest: "assets/javascripts"
          ext: ".js"
        ]
      compile:
        files:
          "main.js": ["library/coffee/{,*/}*.{coffee,litcoffee,coffee.md}"]

    sass:
      dist:
        files:
          "style.css": ["library/styles/{,*/}*.{scss,sass}"]

    watch:
      coffee:
        files: ["library/coffee/{,*/}*.{coffee,litcoffee,coffee.md}"]
        tasks: [
          "coffee"
          "uglify"
        ]
      sass:
        files: ["library/styles/{,*/}*.{scss,sass}"]
        tasks: ['sass']

    clean:
      dist:
        files:
          src: [
            "assets"
            "style.css"
          ]

    copy:
      dist:
        files: [
          {
            src: [
              # add bower components here after bower install
              # "bower_components/bootstrap/dist/js/bootstrap.js"
              "bower_components/jquery/dist/jquery.js"
            ]
            dest: "assets/javascripts/vendor.js"
          }
          {
            src: [
              # add bower components here after bower install
              # "bower_components/bootstrap/dist/css/bootstrap.css"
            ]
            dest: "assets/styles/vendor.css"
          }
        ]

    uglify:
      dist:
        files: [
          {
            src: "assets/javascripts/vendor.js"
            dest: "assets/javascripts/vendor.js"
          }
          {
            src: "main.js"
            dest: "main.js"
          }
        ]

    cssmin:
      dist:
        files: [
          {
            src: "assets/styles/vendor.css"
            dest: "assets/styles/vendor.css"
          }
          {
            src: "style.css"
            dest: "style.css"
          }
        ]

  grunt.registerTask "compile", [
    "clean",
    "coffee",
    "sass",
    "copy:dist",
    "uglify",
    "cssmin"
  ]
