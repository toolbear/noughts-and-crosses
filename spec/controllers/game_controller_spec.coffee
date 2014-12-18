describe "controller: GameController", ->

  cross = "\u2573" # TODO: DRY with src

  Given -> module("app")

  Given inject ($controller, $rootScope) ->
    @scope    = $rootScope.$new()
    $controller('GameController', {$scope: @scope})

  Then -> @scope.player == "Player One"
  And  -> @scope.message == "#{cross} to move"
  And  -> expect(@scope.board).toBeDefined()

  Invariant -> @scope.board.length == 9

  # TODO: smells of an implementation detail
  describe "board is a flattened 3x3 grid with algebraic notation", ->
    When  -> @square = @scope.board[@index]

    describe "top-left", ->
      Given -> @index = 0
      Then -> @square.id == 'a3'

    describe "bottom-right", ->
      Given -> @index = 8
      Then -> @square.id == 'c1'

  describe "#mark()", ->
    Given -> @index = 0
    When  -> @square = @scope.board[@index]
    When  -> @scope.mark(@square)
    Then  -> @square.mark == cross
