angular.module "yostreet.app"
       .controller "InterfaceController", ($rootScope, $scope, $state) ->

  # ---------------------------
  # Initialize
  # ---------------------------
  do @init = =>
