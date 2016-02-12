angular = require('angular')
_ = require('lodash')
'use strict'


SettingsController = ($scope, $location, $rootScope, $routeParams, domainService) ->
  $rootScope.activeNav = 'settings'
  $rootScope.activeDomainId = $routeParams.domainId

  $scope.allEmails = [];
  $scope.activatedEmails = [];

  $scope.activateForAllEmails = false;

  $scope.pageNumber = $routeParams.page or 1
  $scope.pageSize = 16
  $scope.numPages = 0

  $scope.toggleEmailBlacklisted = (whitelist, email) ->
    email.updating = true
    domainService.updateEmail(email.id, {blacklisted: email.blacklisted}).success((response) ->
      _.merge(email, response)
      email.updating = false
    )

  $scope.toggleEmailWhitelisted = (whitelist, email) ->
    email.updating = true
    domainService.updateEmail(email.id, {whitelisted: email.whitelisted}).success((response) ->
      _.merge(email, response)
      email.updating = false
    )

  $scope.toggleActivateForAllEmails = () ->
    console.log($scope.activateForAllEmails)
    domainService.updateDomain($rootScope.activeDomainId, {whitelisted: $scope.activateForAllEmails})

  $scope.getPageNavLink = (pageNum) ->
    return '/app/domains/' + $rootScope.activeDomainId + '/settings?page=' + pageNum

  $scope.getPageNumbers = (num) ->
    return _.range(1, num + 1)

  domainService.getDomainEmails($rootScope.activeDomainId, $scope.pageNumber, $scope.pageSize).success((response) ->
    $scope.numPages = Math.ceil(response.count / $scope.pageSize)
    $scope.allEmails = response.results
  )

  domainService.getDomain($rootScope.activeDomainId).success((response) ->
    $scope.activateForAllEmails = response.whitelisted
  )


SettingsController.$inject = ['$scope', '$location', '$rootScope', '$routeParams', 'domainService']

# export the controller
module.exports = SettingsController
