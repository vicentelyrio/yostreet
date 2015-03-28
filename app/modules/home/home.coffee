angular.module "yostreet.app"
  .config ($stateProvider) ->
    $stateProvider
      .state "app.home",
        url: "/home"
        private: true
        views:

          "":
            controller: "HomeController as hc"
            templateUrl: "modules/home/home.html"

          "header":
            controller: "HeaderController as hl"
            templateUrl: "modules/header/header.html"
