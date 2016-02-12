angular = require('angular')
beakerHttpService = require('./beakerHttp')
fourOhFourController = require('./fourOhFourController')
rootRouterController = require('./rootRouterController')

'use strict'


# define the domain angular module
base = angular.module('beaker.base', [])

# register factories
base.factory 'beakerHttp', beakerHttpService

# register the controllers with the app module
base.controller 'fourOhFourController', fourOhFourController
base.controller 'rootRouterController', rootRouterController

# export the module
module.exports = base