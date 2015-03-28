angular.module "digimap.app"
       .factory "sessionInjector", ($q, $location) ->

  # request: (config) ->
  #   console.log config

  requestError: (rejection) ->
    # return responseOrNewPromise  if canRecover(rejection)
    $q.reject rejection

  response: (response) ->
    response

  responseError: (rejection) ->
    # return responseOrNewPromise  if canRecover(rejection)
    if rejection.status is 401 or rejection.status is 403
      delete localStorage.$LoopBack$currentUserId
      delete localStorage.$LoopBack$accessTokenId
      $location.nextAfterLogin = $location.path()
      $location.path '/login'

    $q.reject rejection
