angular
  .module "yostreet.app"
  .controller "GalleryListController", ($state, Flickr) ->

    @showPhotos = (photo) =>
      $state.go "app.gallery.details", {id: photo.id}

    @getAlbums = =>
      @gallery.loading = true

      Flickr
        .getAlbum()
        .then (data) =>
          list = data.data.photoset

          @gallery.total = parseInt list.total
          @gallery.pages = parseInt list.pages
          @gallery.page = parseInt list.page
          @gallery.perpage = parseInt list.perpage

          for item in list.photo
            photo =
              title: item.title
              image: "https://farm" + item.farm + ".staticflickr.com/" + item.server + "/" + item.id + "_" + item.secret + "_n.jpg"

            @gallery.photos.push photo
            @gallery.loading = false

    do @init = =>
      @gallery =
        photos: []
        loading: false
        total: 0
        pages: 0
        page: 0

      @getAlbums()

    return
