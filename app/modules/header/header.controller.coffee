angular.module "yostreet.app"
       .controller "HeaderController", ($rootScope, $scope, $state) ->

  # ---------------------------
  # Initialize
  # ---------------------------
  do @init = =>
