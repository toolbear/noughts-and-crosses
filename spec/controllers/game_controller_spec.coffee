describe "controller: GameController", ->

  cross = "\u2573" # TODO: DRY with src

  Given -> module("app")

  Given inject ($controller, $rootScope) ->
    @scope    = $rootScope.$new()
    $controller('GameController', {$scope: @scope})

  Then -> @scope.player == "Player One"
  And  -> @scope.message == "#{cross} to move"
  And  -> expect(@scope.board).toBeDefined()

  # TODO: smells of an implementation detail
  describe "board is a flattened 3x3 grid with algebraic notation", ->

    Then -> @scope.board.length == 9
    And  -> @scope.board[0].id == 'a3'
    And  -> @scope.board[8].id == 'c1'
