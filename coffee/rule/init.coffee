angular = require('angular')

rulesController = require('./rulesController')

rulesService = require('./rulesService')

'use strict'


# define the domain angular module
rule = angular.module('beaker.rule', [])

# register factories
rule.factory 'rulesService', rulesService

# register the controllers with the app module
rule.controller 'rulesController', rulesController

# register directives

# export the module
module.exports = rule
