angular.module "digimap.app"
       .controller "HomeController", ($rootScope, $state, $stateParams, $scope) ->

  @myMapOptions =
    scrollwheel: false
    zoom: 15
    center: new google.maps.LatLng(-23.5489063,-46.6330117);
    mapTypeControl: true
    mapTypeControlOptions:
      style: google.maps.MapTypeControlStyle.DROPDOWN_MENU
      position: google.maps.ControlPosition.RIGHT_TOP
    navigationControl: true
    navigationControlOptions:
      style: google.maps.NavigationControlStyle.SMALL
      position: google.maps.ControlPosition.LEFT_CENTER
    mapTypeId: google.maps.MapTypeId.ROADMAP

  @map = new google.maps.Map document.getElementById("map-canvas"), @myMapOptions

  # zoom to show all the features
  @bounds = new (google.maps.LatLngBounds)
  @map.data.addListener 'addfeature', (e) =>
    @processPoints e.feature.getGeometry(), @bounds.extend, @bounds
    @map.fitBounds @bounds
    return

  # zoom to the clicked feature
  @map.data.addListener 'click', (e) =>
    bounds = new (google.maps.LatLngBounds)
    @processPoints e.feature.getGeometry(), bounds.extend, bounds
    @map.fitBounds bounds
    return

  @processPoints = (geometry, callback, thisArg) =>
    if geometry instanceof google.maps.LatLng
      callback.call thisArg, geometry
    else if geometry instanceof google.maps.Data.Point
      callback.call thisArg, geometry.get()
    else
      geometry.getArray().forEach (g) =>
        @processPoints g, callback, thisArg
        return
    return

  @removeAll = =>
    @map.data.forEach (data) => @map.data.remove data

  $scope.$watch "subsector", =>
    if $scope.subsector
      @removeAll()
      @geojson = @map.data.addGeoJson $scope.subsector.geopolygon
  , true

  $scope.$watch "regionalMaps", =>
    if $scope.regionalMaps
      @removeAll()
      for subsector in $scope.regionalMaps
        @geojson = @map.data.addGeoJson subsector.geopolygon
  , true

  $scope.$watch "cityMaps", =>
    if $scope.cityMaps
      @removeAll()
      for city in $scope.cityMaps
        @geojson = @map.data.addGeoJson city.geopolygon
  , true

  $scope.$watch "sectorMaps", =>
    if $scope.sectorMaps
      @removeAll()
      for sector in $scope.sectorMaps
        @geojson = @map.data.addGeoJson sector.geopolygon
  , true
