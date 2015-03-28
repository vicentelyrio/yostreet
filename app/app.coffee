angular.module "yostreet.app", ["ngSanitize", "ui.router",  "ngCookies", "ngAnimate", "cfp.hotkeys", "ngResource"]
  .config ($stateProvider, $urlRouterProvider, hotkeysProvider, $httpProvider) ->

    # HotKeys Config (TODO: Implement this)
    hotkeysProvider.includeCheatSheet = false

    # Base URL
    $urlRouterProvider.otherwise "/home"

    # Set StateProvider
    $stateProvider
      .state "app",
        abstract: true
        url: ""
        controller: "InterfaceController"
        templateUrl: "modules/interface.html"

  .run ($rootScope, $state) ->

    # $rootScope.$on "$stateChangeStart",(event, toState, toParams, fromState, fromParams) ->
    #
    #   # Redirect to Login if the page is private and the user is not authenticated
    #   if not User.isAuthenticated() and toState.private
    #     event.preventDefault()
    #     $state.go "app.login"
