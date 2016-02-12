angular = require('angular')


'use strict'


domainService = ($q, $http, bHttp) ->

  domainCache = {}

  getDomainsByOrg = (org) ->
    return bHttp.get('/organizations/' + org.id + '/domains/')

  getDomain = (domainId) ->
    if domainId of domainCache
      # Domain is in cache, return a promise that returns the domain
      deferred = $q.defer()
      deferred.resolve(domainCache[domainId]);
      deferred.promise.success = (fn) ->
        deferred.promise.then(->
          fn.apply(this, arguments)
        )
      return deferred.promise
    else
      promise = bHttp.get('/domains/' + domainId)
      # Put it in the cache
      promise.success((domain) ->
        domainCache[domain.id] = domain
      )
      return promise

  createDomain = (orgId, domainModel) ->
    return bHttp.post('/domains/', domainModel)

  updateDomain = (domainId, data) ->
    return bHttp.patch('/domains/' + domainId, data)

  getDomainEmails = (domainId, pageNumber=1, pageSize=10) ->
    return bHttp.get('/domains/' + domainId + '/emails/?page_size=' + pageSize + '&page=' + pageNumber)

  getDomainEmailsWhitelist = (domainId) ->
    return bHttp.get('/domains/' + domainId + '/whitelist/')

  getDomainEmailsBlacklist = (domainId) ->
    return bHttp.get('/domains/' + domainId + '/blacklist/')

  updateEmail = (emailId, data) ->
    return bHttp.patch('/emails/' + emailId, data).success((domain) ->
      domainCache[domain.id] = domain
    )

  return {
    createDomain: createDomain,
    getDomain: getDomain,
    getDomainsByOrg: getDomainsByOrg,
    getDomainEmails: getDomainEmails,
    getDomainEmailsWhitelist: getDomainEmailsWhitelist,
    getDomainEmailsBlacklist: getDomainEmailsBlacklist,
    updateDomain: updateDomain,
    updateEmail: updateEmail,
  }

# Inject angular dependencies
domainService.$inject = ['$q', '$http', 'beakerHttp']

# export the factory
module.exports = domainService
