describe "controller: GameController", ->

  cross = "\u2573" # TODO: DRY with src

  Given -> module("app")

  Given inject ($controller, $rootScope) ->
    @scope    = $rootScope.$new()
    $controller('GameController', {$scope: @scope})

  Then -> @scope.player == "Player One"
  And  -> @scope.message == "#{cross} to move"
