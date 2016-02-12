angular = require('angular')


'use strict'


DashboardController = ($scope, $location, $rootScope, $routeParams, userService, domainService) ->
  $rootScope.activeNav = 'dashboard'
  $rootScope.activeDomainId = $routeParams.domainId

  $scope.domain = {}

  domainService.getDomain($rootScope.activeDomainId).success((domain) ->
    $scope.domain = domain
  )


DashboardController.$inject = ['$scope', '$location', '$rootScope', '$routeParams', 'userService', 'domainService']

# export the controller
module.exports = DashboardController
