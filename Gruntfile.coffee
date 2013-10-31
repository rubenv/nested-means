module.exports = (grunt) ->
    @loadNpmTasks('grunt-browserify')
    @loadNpmTasks('grunt-contrib-clean')
    @loadNpmTasks('grunt-contrib-jshint')
    @loadNpmTasks('grunt-contrib-uglify')
    @loadNpmTasks('grunt-contrib-watch')
    @loadNpmTasks('grunt-mocha-cli')
    @loadNpmTasks('grunt-release')

    @initConfig
        clean:
            dist: ['dist']

        browserify:
            dist:
                files:
                    'dist/nested-means.js': ['lib/index.js']
                options:
                    alias: 'lib/index.js:nested-means'

        uglify:
            dist:
                files:
                    'dist/nested-means.min.js': 'dist/nested-means.js'

        jshint:
            all: [ 'lib/**.js' ]
            options:
                jshintrc: '.jshintrc'

        doWatch:
            all:
                files: ['lib/**.js']
                tasks: ['build']
            test:
                files: ['lib/**.js', 'test/**.coffee']
                tasks: ['mochacli']

        mochacli:
            options:
                files: 'test/*_test.coffee'
                compilers: ['coffee:coffee-script']
            spec:
                options:
                    reporter: 'spec'


    @renameTask 'watch', 'doWatch'

    @registerTask 'default', ['test']
    @registerTask 'test', ['build', 'mochacli']
    @registerTask 'build', ['clean', 'jshint', 'browserify', 'uglify']
    @registerTask 'package', ['build', 'release']
    @registerTask 'watch', ['build', 'doWatch']
