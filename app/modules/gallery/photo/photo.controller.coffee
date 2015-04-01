angular
  .module "yostreet.app"
  .controller "GalleryPhotoController", ($rootScope, $state, Flickr, Albums) ->

    @getPhoto = (id) =>
      @photo = ($rootScope.gallery.photos.filter (obj) -> obj.id is id)[0]

    @getAlbums = =>
      Flickr
        .getAlbum()
        .then (data) ->
          $rootScope.gallery = Albums.parse(data)

    @changeImage = (next) =>
      @idx = $rootScope.gallery.photos.indexOf @photo
      if next then @idx++ else @idx--
      id = $rootScope.gallery.photos[@idx].id
      $state.go "app.gallery.photo", { id:id }

    do @init = =>
      @getAlbums() if not $rootScope.gallery

    $rootScope.$watchCollection "gallery", =>
      return unless $rootScope.gallery
      @getPhoto $state.params.id

    return
