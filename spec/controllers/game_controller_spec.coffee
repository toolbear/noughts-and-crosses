describe "controller: GameController", ->

  Given -> module("app")

  Given inject ($controller, $rootScope, MARKS) ->
    @scope    = $rootScope.$new()
    @log = @scope.log = jasmine.createSpy("#log")
    MARKS.nought = "O"
    MARKS.cross  = "X"
    $controller('GameController', {$scope: @scope, MARKS})

  Then -> @scope.player == "Player One"
  And  -> @scope.message == "X to move"
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
    Given -> @square = @scope.board[@index]

    When  -> @scope.mark(@square)

    Then  -> @square.mark == "X"
    And   -> expect(@log).toHaveBeenCalledWith("Xa3")

    describe "already marked", ->
      Given -> @square.mark = "X"
      Then  -> expect(@log).not.toHaveBeenCalled()

    describe "marked by opponent", ->
      Given -> @square.mark = "O"

      Then  -> @square.mark == "O"
      And   -> expect(@log).not.toHaveBeenCalled()
