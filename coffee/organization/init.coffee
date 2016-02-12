angular = require('angular')
createOrganizationController = require('./createOrganizationController')

'use strict'


# define the domain angular module
organization = angular.module('beaker.organization', [])

# register factories

# register the controllers with the app module
organization.controller 'createOrganizationController', createOrganizationController

# export the module
module.exports = organization