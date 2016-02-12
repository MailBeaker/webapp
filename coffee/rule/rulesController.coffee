angular = require('angular')
ruleModalTemplate = require('./ruleModalTemplate.html')
_ = require('lodash')

'use strict'


RulesController = ($scope, $location, $rootScope, $routeParams, userService, rulesService, $modal) ->
  $rootScope.activeNav = 'rules'
  $rootScope.activeDomainId = $routeParams.domainId

  ruleDialog = null

  $scope.pageNumber = $routeParams.page or 1
  $scope.pageSize = 10
  $scope.numPages = 0

  $scope.editingRule = false
  $scope.rules = []
  $scope.newRule = null
  $scope.newRuleDisableSubmit = false

  $scope.expandCollapseRule = (rule) ->
    if not rule.expanded
      rule.expanded = true
    else
      rule.expanded = !rule.expanded

  $scope.openAddRuleDialog = () ->
    ruleDialog = $modal.open({
      template: ruleModalTemplate,
      scope: $scope
    })

  $scope.openEditRuleDialog = (rule) ->
    $scope.newRule = rule
    $scope.editingRule = true
    ruleDialog = $modal.open({
      template: ruleModalTemplate,
      scope: $scope
    })

  $scope.closeRuleDialog = () ->
    ruleDialog.close()
    initializeNewRule()

  $scope.createNewRule = (newRule) ->
    $scope.newRuleDisableSubmit = true
    rulesService.createRule($rootScope.activeDomainId, newRule).success((rule) ->
      $scope.rules.push(rule)
      $scope.newRuleDisableSubmit = false
      $scope.closeRuleDialog()
      initializeNewRule()
    )

  $scope.editRule = (ruleToEdit) ->
    $scope.newRuleDisableSubmit = true
    rulesService.updateRule(ruleToEdit.id, ruleToEdit).then((rule) ->
      _.merge(ruleToEdit, rule)
      $scope.newRuleDisableSubmit = false
      $scope.closeRuleDialog()
      $scope.editingRule = false
      initializeNewRule()
    )

  $scope.deleteRule = (ruleToDelete) ->
    rulesService.deleteRule(ruleToDelete.id).then((response) ->
      _.remove($scope.rules, ruleToDelete)
    )

  $scope.getActionVerbose = (action) ->
    if action.toString() == '0'
      return "Pass"
    else if action.toString() == '1'
      return "Warn"
    else if action.toString() == '2'
      return "Block"
    else return ""

  $scope.getModSentenceForm = (mod) ->
    if mod.toString() == '1'
      return "equals"
    else if mod.toString() == '2'
      return "does not equal"
    else if mod.toString() == '3'
      return "contains"
    else if mod.toString() == '4'
      return "does not contain"
    else if mod.toString() == '5'
      return "starts with"
    else if mod.toString() == '6'
      return "ends with"
    else return ""

  $scope.getPageNavLink = (pageNum) ->
    return '/app/domains/' + $rootScope.activeDomainId + '/rules?page=' + pageNum

  $scope.getPageNumbers = (num) ->
    return _.range(1, num + 1)

  $scope.modOptions = () ->
    return [
      {value: 0, label: 'Not defined'}
      {value: 1, label: 'Equal to'}
      {value: 2, label: 'Contains'}
      {value: 3, label: 'Does not contain'}
      {value: 4, label: 'Starts with'}
      {value: 5, label: 'Ends with'}
    ]

  rulesService.getRules($rootScope.activeDomainId, $scope.pageNumber, $scope.pageSize).success((response) ->
    $scope.numPages = Math.ceil(response.count / $scope.pageSize)
    $scope.rules = response.results
  )

  initializeNewRule = () ->
    $scope.newRule = {
      sender_mod: 0,
      receiver_mod: 0,
      subject_mod: 0,
      url_mod: 0,
      body_mod: 0,
      action: "2",
    }

  initializeNewRule()


RulesController.$inject = ['$scope', '$location', '$rootScope', '$routeParams', 'userService', 'rulesService', '$modal']

# export the controller
module.exports = RulesController
