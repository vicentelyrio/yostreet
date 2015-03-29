angular
  .module "yostreet.app"
  .service "Albums", (Image) ->

    parse: (data) ->
      @gallery =
        photos: []
        loading: true
        total: 0
        pages: 0
        page: 0

      list = data.data.photoset

      @gallery.total = parseInt list.total
      @gallery.pages = parseInt list.pages
      @gallery.page = parseInt list.page
      @gallery.perpage = parseInt list.perpage

      for item in list.photo
        photo = item
        photo.thumb = Image.path item, "n"
        photo.image = Image.path item, "c"

        @gallery.photos.push photo
        @gallery.loading = false

      @gallery
