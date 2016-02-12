angular = require('angular')


'use strict'


ruleService = ($q, $http, bHttp) ->

#  ruleCache = {}

  createRule = (domainId, newRule) ->
    return bHttp.post('/domains/' + domainId + '/rules/', newRule)

  deleteRule = (ruleId) ->
    return bHttp.delete('/rules/' + ruleId)

  getRules = (domainId, pageNumber=1, pageSize=10) ->
    return bHttp.get('/domains/' + domainId + '/rules/?page=' + pageNumber + '&page_size=' + pageSize)

  updateRule = (ruleId, data) ->
    return bHttp.patch('/rules/' + ruleId, data)


  return {
    createRule: createRule,
    deleteRule: deleteRule,
    getRules: getRules,
    updateRule: updateRule,
  }

# Inject angular dependencies
ruleService.$inject = ['$q', '$http', 'beakerHttp']

# export the factory
module.exports = ruleService
