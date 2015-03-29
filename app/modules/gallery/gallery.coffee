angular.module "yostreet.app"
  .config ($stateProvider) ->
    $stateProvider
      # Base
      .state "app.gallery",
        abstract: true
        url: "/gallery"
        views:
          "":
            templateUrl: "modules/gallery/gallery.html"
          "header":
            controller: "HeaderController as hl"
            templateUrl: "modules/header/header.html"

      # List
      .state "app.gallery.list",
        url: ""
        controller: "GalleryListController as gc"
        templateUrl: "modules/gallery/list/list.html"
        activePage: "gallery"

      # Details
      .state "app.gallery.photo",
        url: "/photo/:id"
        activePage: "gallery"
        controller: "GalleryPhotoController as pc"
        templateUrl: "modules/gallery/photo/photo.html"
