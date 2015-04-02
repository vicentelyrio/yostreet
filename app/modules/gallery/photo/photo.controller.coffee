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

    @boundaries = (id, max, min) =>
      console.log id, max, min
      return max if id < min
      return min if id > max
      return id

    @changeImage = (next) =>
      list = $rootScope.gallery.photos
      @idx = list.indexOf @photo
      if next then @idx++ else @idx--
      @idx = @boundaries @idx, list.length - 1, 0
      console.log @idx
      id = list[@idx].id
      $state.go "app.gallery.photo", { id:id }

    do @init = =>
      @getAlbums() if not $rootScope.gallery

    $rootScope.$watchCollection "gallery", =>
      return unless $rootScope.gallery
      @getPhoto $state.params.id

    return
