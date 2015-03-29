angular
  .module "yostreet.app"
  .factory "Image", ->

    path: (item, size) ->
      url = "https://farm" + item.farm + ".staticflickr.com/" + item.server + "/" + item.id + "_" + item.secret + "_" + size + ".jpg"
