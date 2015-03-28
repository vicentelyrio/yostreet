angular.module "yostreet.app"
  .config ($stateProvider) ->
    $stateProvider
      .state "app.bio",
        url: "/bio"
        views:
          "":
            controller: "BioController as bc"
            templateUrl: "modules/bio/bio.html"

          "header":
            controller: "HeaderController as hl"
            templateUrl: "modules/header/header.html"
