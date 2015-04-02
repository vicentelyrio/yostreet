angular
  .module "yostreet.app"
  .directive "preloader", ->
    restrict: "E"
    replace: true
    templateUrl: "directives/preloader/preloader.html"
    scope:
      image: "="
    controller: ($scope, $timeout) ->
      image = new Image()

      image.onload = ->
        $timeout ->
          $scope.loading = false

      image.src = $scope.image
      $scope.loading = true
