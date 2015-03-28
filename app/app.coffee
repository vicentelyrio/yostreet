angular.module "digimap.app", ["ngSanitize", "ui.router",  "ngCookies", "ngAnimate", "cfp.hotkeys", "ngMap", "ngResource", "lbServices"]
  .config ($stateProvider, $urlRouterProvider, hotkeysProvider, $httpProvider, LoopBackResourceProvider) ->

    # HotKeys Config (TODO: Implement this)
    hotkeysProvider.includeCheatSheet = false

    # Use a custom auth header instead of the default "Authorization"
    LoopBackResourceProvider.setAuthHeader "X-Access-Token"

    # Change the URL where to access the LoopBack REST API server (TODO: config by env)
    LoopBackResourceProvider.setUrlBase "/api"

    # Session Interceptor
    $httpProvider.interceptors.push "sessionInjector"

    # $httpProvider.defaults.useXDomain = true
    # delete $httpProvider.defaults.headers.common["X-Requested-With"]

    # Base URL
    $urlRouterProvider.otherwise "/home"

    # Set StateProvider
    $stateProvider
      .state "app",
        abstract: true
        url: ""
        controller: "InterfaceController"
        templateUrl: "modules/interface.html"

  .run ($rootScope, $state, User) ->

    $rootScope.$on "$stateChangeStart",(event, toState, toParams, fromState, fromParams) ->

      # Redirect to Login if the page is private and the user is not authenticated
      if not User.isAuthenticated() and toState.private
        event.preventDefault()
        $state.go "app.login"
