angular.module "digimap.app"
        .controller "LoginController", ($state, $stateParams, $scope, User, $location) ->

  # Reset Credentials
  # ---------------------------
  @resetCredentials = =>
    @credentials =
      username: ""
      password: ""

  # Login
  # ---------------------------
  @login = =>

    # Callbacks
    success = (data) =>
      $scope.user = data.user
      $scope.userStatus.logged = true
      $scope.userStatus.logging = false
      @resetCredentials()
      @forward()

    error = (err) ->
      console.log err

    # Call Login
    User.login @credentials, success, error

  # Initialize
  # ---------------------------
  @forward = =>
    next = $location.nextAfterLogin or $state.go "app.home"
    $location.nextAfterLogin = null
    $location.path next
    return

  # Initialize
  # ---------------------------
  @init = =>
    @forward() if $scope.userStatus?.logged

  @init()
