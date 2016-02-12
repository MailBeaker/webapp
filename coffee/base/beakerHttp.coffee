angular = require('angular')


'use strict'


beakerHttp = ($q, $http, $window, $cookies) ->

  baseUrl = '/api/v1/client'
  nonClientBaseUrl = '/api/v1'

  getBaseUrl = (config) ->
    if config.notClient
      return nonClientBaseUrl
    else
      return baseUrl

  get = (urlPath, config={}) ->
    url = getBaseUrl(config) + urlPath
    return $http.get(url, config)

  post = (urlPath, data, config={}) ->
    if not config.headers
      config.headers = {'X-CSRFToken': $cookies.csrftoken}
    else
      config.headers['X-CSRFToken'] = $cookies.csrftoken

    url = getBaseUrl(config) + urlPath
    return $http.post(url, data, config)

  put = (urlPath, data, config={}) ->
    if not config.headers
      config.headers = {'X-CSRFToken': $cookies.csrftoken}
    else
      config.headers['X-CSRFToken'] = $cookies.csrftoken

    url = getBaseUrl(config) + urlPath
    return $http.put(url, data, config)

  del = (urlPath, config={}) ->
    if not config.headers
      config.headers = {'X-CSRFToken': $cookies.csrftoken}
    else
      config.headers['X-CSRFToken'] = $cookies.csrftoken

    url = getBaseUrl(config) + urlPath
    return $http.delete(url, config)

  head = (urlPath, config={}) ->
    url = getBaseUrl(config) + urlPath
    return $http.head(url, config)

  patch = (urlPath, data, config={}) ->
    if not config.headers
      config.headers = {'X-CSRFToken': $cookies.csrftoken}
    else
      config.headers['X-CSRFToken'] = $cookies.csrftoken

    url = getBaseUrl(config) + urlPath
    return $http({method: 'PATCH', url: url, data: data, headers: config.headers})

  return {
    get: get,
    post: post,
    put: put,
    delete: del,
    head: head,
    patch: patch
  }

# Inject angular dependencies
beakerHttp.$inject = ['$q', '$http', '$window', '$cookies']

# export the factory
module.exports = beakerHttp
