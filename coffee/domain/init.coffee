angular = require('angular')
domainDashboardController = require('./dashboardController')
domainNewDomainController = require('./newDomainController')
domainSettingsController = require('./settingsController')

domainService = require('./domainService')

'use strict'


# define the domain angular module
domain = angular.module('beaker.domain', [])

# register factories
domain.factory 'domainService', domainService

# register the controllers with the app module
domain.controller 'domainSettingsController', domainSettingsController
domain.controller 'domainDashboardController', domainDashboardController
domain.controller 'domainNewDomainController', domainNewDomainController

# register directives

# export the module
module.exports = domain
