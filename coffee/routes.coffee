angular = require('angular')
angularRoute = require('angular-route')

domainDashboardTemplate = require('./domain/dashboardTemplate.html')
domainNewDomainTemplate = require('./domain/newDomainTemplate.html')
domainSettingsTemplate = require('./domain/settingsTemplate.html')

rulesTemplate = require('./rule/rulesTemplate.html')

createOrganizationTemplate = require('./organization/createOrganizationTemplate.html')

fourOhFourTemplate = require('./base/fourOhFourTemplate.html')
rootRouterTemplate = require('./base/rootRouterTemplate.html')

authLoginTemplate = require('./auth/loginTemplate.html')
authLogoutTemplate = require('./auth/logoutTemplate.html')

###
@module routes

@description
Defines Mail Beakers's routes.
###
'use strict'


# define the module
routes = angular.module('beaker-routes', ['ngRoute'])

# configure the routes
routes.config ['$routeProvider', ($routeProvider) ->
  $routeProvider.when('/',
    template: rootRouterTemplate
    controller: 'rootRouterController'
  )

  # AUTH ROUTES
  $routeProvider.when('/auth/login/',
    template: authLoginTemplate
    controller: 'authLoginController'
  )

  $routeProvider.when('/auth/logout/',
    template: authLogoutTemplate
    controller: 'authLogoutController'
  )

  # DOMAIN ROUTES
  $routeProvider.when('/domains/:domainId/dashboard',
    template: domainDashboardTemplate
    controller: 'domainDashboardController'
  )

  $routeProvider.when('/domains/:domainId/rules',
    template: rulesTemplate
    controller: 'rulesController'
  )

  $routeProvider.when('/domains/:domainId/settings',
    template: domainSettingsTemplate
    controller: 'domainSettingsController'
  )

  $routeProvider.when('/domains/create',
    template: domainNewDomainTemplate
    controller: 'domainNewDomainController'
  )

  # ORGANIZATION ROUTES
  $routeProvider.when('/organizations/create',
    template: createOrganizationTemplate
    controller: 'createOrganizationController'
  )

  # ERROR ROUTES
  $routeProvider.when('/404',
    template: fourOhFourTemplate
    controller: 'fourOhFourController'
  )

  $routeProvider.otherwise(redirectTo: '/404')
  return
]

# export the module
module.exports = routes
