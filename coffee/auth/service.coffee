angular = require('angular')


'use strict'


authService = ($q, beakerHttp) ->

  loginUser = (userSubmission) ->
    return beakerHttp.post(
      '/auth/login/',
      userSubmission
    )

  logoutUser = () ->
    beakerHttp.post('/auth/logout/', {}, {notClient: true})

  getMetaDict = () ->
    beakerHttp.get('/meta/', {}, {notClient: true})

  return {
    getMetaDict: getMetaDict,
    loginUser: loginUser,
    logoutUser: logoutUser,
  }

# Inject angular dependencies
authService.$inject = ['$q', 'beakerHttp']

# export the factory
module.exports = authService
