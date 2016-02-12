var gulp = require('gulp'),
    watch = require('gulp-watch'),
    browserify = require('browserify'),
    rename = require('gulp-rename'),
    coffeeify = require('coffeeify'),
    partialify = require('partialify'),
    sass = require('gulp-sass'),
    livereload = require('gulp-livereload'),
    source = require('vinyl-source-stream');

var path_to_beaker_static = "../beaker/static/";
var path_to_beaker_staticfiles = "../beaker/staticfiles/";
var path_to_beaker_templates = "../beaker/templates/";

var paths = {
    coffee: "./coffee/",
    sass: "./sass/",
    static: "./static/",
    css: "./static/css/",
    js: "./static/js/",
    img: "./static/img/**",
    templates: "./templates/"
};

var globs = {
    js: "**/*.js",
    coffee: "**/*.coffee",
    html: "**/*.html",
    scss: "**/*.scss",
    css: "**/*.css",
    all: "**/*.*"
};


gulp.task('coffee', function(){
    var entry = paths.coffee + 'app.coffee';
    return browserify({entries: entry, extensions: ['.coffee', '.html']})
        .transform(partialify)
        .transform(coffeeify)
        .bundle()
        .pipe(source("app.js"))
        .pipe(gulp.dest(paths.js));
});

gulp.task('sass', function(){
   return gulp.src(paths.sass + 'app.scss')
              .pipe(sass())
              .pipe(gulp.dest(paths.css));
});

gulp.task('build', ['coffee', 'sass']);

gulp.task('watch', function(){
    watch({glob: paths.coffee + globs.coffee}, function(){
        gulp.start('copy:js');
    });
    watch({glob: paths.coffee + globs.html}, function(){
        gulp.start('copy:js');
    });
    watch({glob: paths.sass + globs.scss}, function(){
        gulp.start('copy:css');
    });
    watch({glob: paths.templates + globs.html}, function(){
        gulp.start('copy:templates');
    });
});

gulp.task('copy:js', ['coffee'], function(){
    gulp.src(paths.static + globs.js)
        .pipe(gulp.dest(path_to_beaker_static));
    return gulp.src(paths.static + globs.js)
        .pipe(gulp.dest(path_to_beaker_staticfiles));
});

gulp.task('copy:css', ['sass'], function(){
    gulp.src(paths.static + globs.css)
        .pipe(gulp.dest(path_to_beaker_static));
    return gulp.src(paths.static + globs.css)
        .pipe(gulp.dest(path_to_beaker_staticfiles));
});

gulp.task('copy:img', function(){
    gulp.src(paths.img).pipe(gulp.dest(path_to_beaker_static + 'img/'));
    return gulp.src(paths.img).pipe(gulp.dest(path_to_beaker_staticfiles + 'img/'));
});

gulp.task('copy:templates', function(){
    return gulp.src(paths.templates + globs.html)
        .pipe(gulp.dest(path_to_beaker_templates));
});

gulp.task('copy', ['copy:js', 'copy:css', 'copy:img', 'copy:templates'], function(){
});

gulp.task('dev', ['build', 'copy'], function(){
    return gulp.start('watch');
});

gulp.task('default', function() {
  gulp.start('build');
});
