angular.module "digimap.app"
  .config ($stateProvider) ->
    $stateProvider
      .state "app.login",
        url: "/login"
        private: false
        views:
          "":
            controller: "LoginController"
            templateUrl: "modules/login/login.html"
