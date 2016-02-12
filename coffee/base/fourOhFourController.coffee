angular = require('angular')


'use strict'


fourOhFourController = ($scope, $location, $rootScope) ->
  $rootScope.activeNav = ''


fourOhFourController.$inject = ['$scope', '$location', '$rootScope']

# export the controller
module.exports = fourOhFourController
