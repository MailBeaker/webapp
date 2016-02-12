angular = require('angular')


'use strict'


createOrganizationController = ($scope, $location, $rootScope) ->
  $rootScope.activeNav = 'create_organization'


createOrganizationController.$inject = ['$scope', '$location', '$rootScope']

# export the controller
module.exports = createOrganizationController
