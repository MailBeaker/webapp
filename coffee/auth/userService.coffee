
'use strict'

userService = ($rootScope, $cookies) ->

  isAuthenticated = false
  user = null
  membership = null
  organization = null
  csrf_token = $cookies.csrftoken

  #TODO make this more sane
  reset = () ->
    this.isAuthenticated = false
    this.user = null
    this.membership = null
    this.organization = null
    $rootScope.user = null
    $rootScope.membership = null
    $rootScope.organization = null
    $rootScope.isAuthenticated = false

  return {
    isAuthenticated: isAuthenticated,
    user: user,
    membership: membership,
    organization: organization,
    reset: reset,
    csrf_token: csrf_token
  }

userService.$inject = ['$rootScope', '$cookies']

module.exports = userService
