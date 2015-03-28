angular.module "digimap.app"
       .controller "HeaderController", ($rootScope, $scope, $state, User, Regional, City, Sector, Subsector) ->

  # ---------------------------
  # Logout
  # ---------------------------
  @logout = =>

    # Callbacks
    success = ->
      delete localStorage.$LoopBack$currentUserId
      delete localStorage.$LoopBack$accessTokenId
      $state.go "app.login"
      $scope.userStatus.logged = false
      $scope.userStatus.logging = false
    error = (err) -> console.log err

    # Call Login
    User.logout success, error

  # ---------------------------
  # Get App data
  # ---------------------------
  @getQuery = (id) =>
    q =
      order: "name DESC"
      id: id

  @getData = () =>
    $scope.regionals = []
    $scope.cities = []
    $scope.sectors = []
    $scope.subsectors = []

    Regional.find {order: "name DESC"}, (data) ->
      for item in data
        $scope.regionals.push
          id: item.id
          name: item.name

  $scope.selectRegional = (item) =>
    $rootScope.regional = item
    $rootScope.regionalMaps = []
    $scope.cities = []
    $scope.sectors = []
    $scope.subsectors = []

    if item.id isnt 0
      Regional.cities @getQuery(item.id), (data) =>
        $scope.cities = data
        for city in data
          City.sectors @getQuery(city.id), (data) =>
            for sector in data
              Sector.subsectors @getQuery(sector.id), (data) =>
                for subsector in data
                  Subsector.findById id: subsector.id, (data) =>
                    $rootScope.regionalMaps.push data

  $scope.selectCity = (item) =>
    $rootScope.city = item
    $rootScope.cityMaps = []
    $scope.sectors = []
    $scope.subsectors = []

    if item.id isnt 0
      City.sectors @getQuery(item.id), (data) =>
        $scope.sectors = data
        for sector in data
          Sector.subsectors @getQuery(sector.id), (data) =>
            for subsector in data
              Subsector.findById id: subsector.id, (data) =>
                $rootScope.cityMaps.push data

  $scope.selectSector = (item) =>
    $rootScope.sector = item
    $rootScope.sectorMaps = []
    $scope.subsectors = []

    if item.id isnt 0
      Sector.subsectors @getQuery(item.id), (data) =>
        $scope.subsectors = data
        for subsector in data
          Subsector.findById id: subsector.id, (data) =>
            $rootScope.sectorMaps.push data

  $scope.selectSubsector = (item) =>
    $rootScope.subsector = item

    if item.id isnt 0
      Subsector.findById id: item.id, (data) =>
        $scope.subsector = data

  # ---------------------------
  # Initialize
  # ---------------------------
  @init = =>
    $scope.logout = @logout
    @getData() if User.isAuthenticated()
  @init()
