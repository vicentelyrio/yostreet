angular
  .module "yostreet.app"
  .controller "GalleryPhotoController", ($rootScope, $state, Flickr, Albums) ->

    @getPhoto = (id) =>
      console.log $rootScope.gallery
      @photo = ($rootScope.gallery.photos.filter (obj) -> obj.id is id)[0]

    @getAlbums = =>
      Flickr
        .getAlbum()
        .then (data) ->
          $rootScope.gallery = Albums.parse(data)

    do @init = =>
      @getAlbums() if not $rootScope.gallery

    $rootScope.$watchCollection "gallery", =>
      return unless $rootScope.gallery
      @getPhoto $state.params.id

    return
