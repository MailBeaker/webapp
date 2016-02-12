angular = require('angular')


'use strict'


LogoutController = ($scope, $location, $rootScope, authService, userService) ->
  $rootScope.activeNav = 'logout'

  userService.reset()
  authService.logoutUser().success((response) ->
    $location.path('/auth/login/')
    return
  )


LogoutController.$inject = ['$scope', '$location', '$rootScope', 'authService', 'userService']

# export the controller
module.exports = LogoutController
