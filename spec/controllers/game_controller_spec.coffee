describe "controller: GameController", ->

  Given -> module("app")

  Given inject ($controller, $rootScope, MARKS) ->
    @scope       = $rootScope.$new()
    @log         = @scope.log = jasmine.createSpy("#log")
    MARKS.nought = "O"
    MARKS.cross  = "X"
    $controller('GameController', {$scope: @scope, MARKS})

  Given -> @board = @scope.board

  Then  -> @scope.player == "Player One"
  And   -> @scope.message == "X to move"

  Invariant -> @board.length == 9

  describe "board is a flattened 3x3 grid with algebraic notation", ->
    When  -> @square = @board[@index]

    describe "top-left", ->
      Given -> @index = 0
      Then  -> @square.id == 'a3'

    describe "bottom-right", ->
      Given -> @index = 8
      Then  -> @square.id == 'c1'

  describe "#mark()", ->
    Given -> @index = 0
    Given -> @square = @board[@index]

    When  -> @scope.mark(@square)

    Then  -> @square.mark == "X"
    And   -> expect(@log).toHaveBeenCalledWith("Xa3")
    And   -> @scope.message == "O to move"

    describe "already marked", ->
      Given -> @square.mark = "X"
      Then  -> expect(@log).not.toHaveBeenCalled()

    describe "marked by opponent", ->
      Given -> @square.mark = "O"

      Then  -> @square.mark == "O"
      And   -> expect(@log).not.toHaveBeenCalled()

    describe "switches to opponent mark", ->
      Given -> @secondSquare = id: "c2"

      When  -> @scope.mark(@secondSquare)

      Then  -> @secondSquare.mark == "O"
      And   -> @scope.message = "X to move"

      describe "switches back to original player mark", ->
        Given -> @thirdSquare = id: "c3"
        When  -> @scope.mark(@thirdSquare)
        Then  -> @thirdSquare.mark == "X"

  describe "game ends in a draw", ->
    Given ->
      setup = "XOX
               XOO
               OX_"
      for mark, i in setup.replace /\s/g, ""
        @board[i].mark = mark if mark != "_"

    When  -> @scope.mark(@board[8])

    Then  -> @scope.message == "Game Over: It's a Draw"

  describe "winning", ->
    Given ->
      setup = "X_X
               O__
               OOX"
      for mark, i in setup.replace /\s/g, ""
        @board[i].mark = mark if mark != "_"

    describe "3 across", ->
      When  -> @scope.mark(@board[1])
      Then  -> @scope.message == "Winner: X"

      describe "keep playing", ->
        Given -> @square = @board[4]
        When  -> @scope.mark(@square)
        Then  -> expect(@square.mark).toBeUndefined()

    describe "3 down", ->
      When  -> @scope.mark(@board[5])
      Then  -> @scope.message == "Winner: X"

    describe "3 diagonal", ->
      When  -> @scope.mark(@board[4])
      Then  -> @scope.message == "Winner: X"
