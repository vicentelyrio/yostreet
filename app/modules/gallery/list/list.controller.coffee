angular
  .module "yostreet.app"
  .controller "GalleryListController", ($rootScope, $state, Flickr, Albums) ->

    @showPhoto = (photo) =>
      $state.go "app.gallery.photo", { id: photo.id }

    @getAlbums = =>
      @isLoading = true
      Flickr
        .getAlbum()
        .then (data) =>
          $rootScope.gallery = Albums.parse(data)
          @isLoading = false

    do @init = =>
      @getAlbums() if not $rootScope.gallery

    return
