###
@module app

@description
Initialize and bootstrap the angular application.
###

angular = require('angular')
angularBootstrap = require('angular-bootstrap')
ngCookies = require('angular-cookies')

routes = require('./routes')
auth = require('./auth/init')
base = require('./base/init')
domain = require('./domain/init')
rule = require('./rule/init')
organization = require('./organization/init')

# Create the Mail Beaker module
appName = 'beaker'
app = angular.module(appName, [
  'ngRoute'
  'ngCookies'
  'ui.bootstrap'
  routes.name
  auth.name
  base.name
  domain.name
  rule.name
  organization.name
])

app.config(['$locationProvider', ($locationProvider) ->
  $locationProvider.html5Mode(true)
  return
])

app.factory('unauthenticatedResponseInterceptor', ['$q', '$location', ($q, $location) ->
  success = (response) ->
      return response

  error = (response) ->
    # Handle 401 errors by redirecting to the login page
    console.log($location.path())
    if response.status == 401 or response.status == 403
      previous_path = $location.path() == '/auth/login/' ? '/' : $location.path()
      $location.path('/auth/login/').search({next: previous_path})
      return $q.reject(response)
    # Otherwise
    return $q.reject(response)

  return (promise) ->
      return promise.then(success, error)
])

app.config(['$httpProvider', ($httpProvider) ->
  $httpProvider.responseInterceptors.push('unauthenticatedResponseInterceptor')
  return
])

app.run(($rootScope, $window, $location, authService, userService)->
  if not window.meta.user
    authService.getMetaDict().success((data) ->
      console.log("got some meta dict!")
      userService.user = data.user
      userService.organization = data.organization
      userService.membership = data.membership
      userService.isAuthenticated = true
    )
  else
    userService.user = window.meta.user
    userService.organization = window.meta.organization
    userService.membership = window.meta.membership
    userService.isAuthenticated = true
  $rootScope.userService = userService
)

angular.element(document).ready ->
  angular.bootstrap document, [appName]
