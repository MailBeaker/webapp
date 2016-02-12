angular = require('angular')

authService = require('./service')
loginController = require('./loginController')
logoutController = require('./logoutController')
userService = require('./userService')

'use strict'


# define the domain angular module
auth = angular.module('beaker.auth', [])

# register factories
auth.factory 'authService', authService
auth.factory 'userService', userService

# register the controllers with the app module
auth.controller 'authLoginController', loginController
auth.controller 'authLogoutController', logoutController

# export the module
module.exports = auth