'use strict'

HomeCtrl = (
  $scope, $rootScope, $location
  $ionicScrollDelegate
  $log, toastr
  utils, devConfig, exportDebug
  )->

  vm = this
  vm.title = "Home"
  vm.me = null      # current user, set in initialize()
  vm.acl = {
    isVisitor: ()->
      return true if !$rootScope.user
    isUser: ()->
      return true if $rootScope.user
  }
  vm.settings = {
    show: 'less'
  }
  vm.on = {
    scrollTo: (anchor)->
      $location.hash(anchor)
      $ionicScrollDelegate.anchorScroll(true)
      return
      
    setView: (value)->
      return vm.settings.show = 'less' ? 'more' : 'less' if 'value==null'
      return vm.settings.show = value 

    click: (ev)->
      toastr.info("something was clicked")
  }

  initialize = ()->
    DEV_USER_ID = '0'
    devConfig.loginUser( DEV_USER_ID ).then (user)->
      # loginUser() sets $rootScope.user
      vm.me = $rootScope.user
      toastr.info "Login as userId=0"
    return

  activate = ()->
    return

  $scope.$on '$ionicView.loaded', (e)->
    $log.info "viewLoaded for HomeCtrl"
    initialize()

  $scope.$on '$ionicView.enter', (e)->
    $log.info "viewEnter for HomeCtrl"
    activate()

  return # end HomeCtrl


HomeCtrl.$inject = [
  '$scope', '$rootScope', '$location'
  '$ionicScrollDelegate'
  '$log', 'toastr'
  'utils', 'devConfig', 'exportDebug'
]

angular.module 'starter.home'
  .controller 'HomeCtrl', HomeCtrl




