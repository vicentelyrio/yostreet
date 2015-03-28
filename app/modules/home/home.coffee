angular.module "yostreet.app"
  .config ($stateProvider) ->
    $stateProvider
      .state "app.home",
        url: "/home"
        private: true
        views:

          "":
            controller: "HomeController"
            templateUrl: "modules/home/home.html"

          "header":
            controller: "HeaderController"
            templateUrl: "modules/header/header.html"
