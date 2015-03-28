angular.module "yostreet.app"
       .directive "preload", ->
  restrict: "A"
  link: (scope, element, attrs) ->
    element.bind "load", ->
      scope.$apply ->
        scope.$eval(attrs.callback)
