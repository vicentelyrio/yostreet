angular.module "yostreet.app"
       .directive "selector", ->
  restrict: "E"
  templateUrl: "directives/selector/selector.html"
  replace: true
  controllerAs: "ss"
  scope:
    itemList: "="
    itemLabel: "="
    itemDefault: "="
    itemSelected: "="
    onSelect: "="
  controller: ($scope, $document, $element, $timeout) ->

    # Set Default Item
    @setDefaultItem = =>
      @defaultItem =
        id: 0
        name: $scope.itemDefault
        label: "Todos"

      @itemList.unshift @defaultItem

    # Set Selected Item
    @setSelectedItem = =>
      return unless $scope.itemSelected
      if not $scope.itemSelected or not $scope.itemSelected.name
        $scope.itemSelected = @defaultItem

    # Select Item
    @selectItem = (item) =>
      $scope.itemSelected = item
      $scope.onSelect(item) if $scope.onSelect

    # Select Auto Closer
    @selectAutoClose = (e) =>
      unless e.target in $element
        $document.off "click", @selectAutoClose
        $timeout -> $scope.opened = false

    # Open Select
    @openSelect = =>
      $scope.opened = !$scope.opened
      if $scope.opened
        $document.on "click", @selectAutoClose
      else
        $document.off "click", @selectAutoClose
      return

    # Initialize
    @init = =>
      $scope.opened = false
      @itemList = angular.copy $scope.itemList
      @setDefaultItem() if $scope.itemDefault

      $scope.$watch "itemSelected",
        @setSelectedItem
      , true

    $scope.$watch "itemList", (nv, ov) =>
      @init()
    , true
