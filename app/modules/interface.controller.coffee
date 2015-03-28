angular.module "digimap.app"
       .controller "InterfaceController", ($rootScope, $scope, $state, User) ->

  # ---------------------------
  # Get User Info
  # ---------------------------
  @getUserInfo = =>
    success =  (data) ->
      $scope.user = data
      $scope.userStatus.logged = true
      $scope.userStatus.logging = false

    User.getCurrent(success)

  # ---------------------------
  # Initialize
  # ---------------------------
  @init = =>
    $scope.logout = @logout

    $scope.userStatus =
      logging: false
      logged: false

    if User.isAuthenticated()
      @getUserInfo()

  @init()
