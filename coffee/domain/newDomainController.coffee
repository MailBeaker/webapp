angular = require('angular')


'use strict'


NewDomainController = ($scope, $location, $rootScope, authService) ->
  $rootScope.activeNav = 'new_domain'

  $scope.domain = {
    records: []
  }
  $scope.lookingUpMx = false

  tempDomainName = ""

  $scope.domainBlur = (domainName) ->
    if domainName != tempDomainName
      tempDomainName = domainName
      $scope.lookingUpMx = true
      authService.lookupMxRecords(domainName).success((records) ->
        $scope.domain.records = records
        $scope.lookingUpMx = false
      )

  $scope.addMxRecord = () ->
    $scope.domain.records.push({hostname: "", priority: ""})

  $scope.formSubmitted = (newDomain) ->
    if $scope.domain.records.length == 0
      $scope.domainBlur(newDomain.domain_name)
    else
      console.log(newDomain)


NewDomainController.$inject = ['$scope', '$location', '$rootScope', 'authService']

# export the controller
module.exports = NewDomainController
