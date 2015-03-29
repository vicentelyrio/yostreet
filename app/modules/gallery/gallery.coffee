angular.module "yostreet.app"
  .config ($stateProvider) ->
    $stateProvider
      .state "app.gallery",
        abstract: true
        url: "/gallery"
        templateUrl: "modules/gallery/gallery.html"

      .state "app.gallery.list",
        url: ""
        controller: "GalleryListController as gc"
        templateUrl: "modules/gallery/list/list.html"
        activePage: "gallery"

      .state "app.gallery.details",
        url: "/details/:id"
        activePage: "gallery"
        controller: "GalleryDetailsController as dc"
        templateUrl: "modules/gallery/details/details.html"
