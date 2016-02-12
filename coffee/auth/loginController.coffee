angular = require('angular')


'use strict'


LoginController = ($scope, $location, $rootScope, authService, userService) ->
  $rootScope.activeNav = 'login'

  $scope.credentials = {}

  $scope.login = (submission) ->
    authService.loginUser(submission).success((data) ->
      console.log("About to set path")
      userService.user = data.user
      userService.organization = data.organization
      userService.membership = data.membership
      userService.isAuthenticated = true
      $location.path("/")
      console.log("Just set the path.")
    )

  if userService.isAuthenticated
    console.log("kkkk")
    $location.path("/")


LoginController.$inject = ['$scope', '$location', '$rootScope', 'authService', 'userService']

# export the controller
module.exports = LoginController
