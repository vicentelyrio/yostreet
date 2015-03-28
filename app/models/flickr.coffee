angular
  .module "yostreet.models"
  .service "Flickr", ($http, FLICKR) ->

    getAlbum: ->
      $http.jsonp FLICKR.url,
        params:
          method: "flickr.photosets.getPhotos"
          api_key: FLICKR.api_key
          user_id: FLICKR.user_id
          photoset_id: FLICKR.album_id
          per_page: FLICKR.per_page
          format: "json"
          jsoncallback: "JSON_CALLBACK"
