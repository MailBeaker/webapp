angular = require('angular')


'use strict'


rootRouterController = ($scope, $location, $rootScope, userService, domainService) ->
  $rootScope.activeNav = ''

  if not userService.isAuthenticated
    console.log("NOT AUTHENTICATED")
    $location.path('/auth/login/')
    return

  if userService.organization and userService.organization.id
    domainsRequest = domainService.getDomainsByOrg(userService.organization)
    domainsRequest.success((response) ->
      console.log(response);
      if response.count > 1
        console.log("MULTIPLE DOMAINS!")
      else if response.count == 1
        domain = response.results[0]
        console.log("Found one domain, let's go to dashboard")
        $location.path('/domains/' + domain.id + '/dashboard')
        $rootScope.activeDomainId = domain.id
      else
        console.log("Did not find domains.")
        $location.path('domains/create')
    )
  else
    $location.path('/organizations/create')


rootRouterController.$inject = ['$scope', '$location', '$rootScope', 'userService', 'domainService']

# export the controller
module.exports = rootRouterController
