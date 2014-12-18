describe "controller: GameController", ->

  # TODO: DRY with src
  cross  = "\u2573"
  nought = "\u25ef"

  Given -> module("app")

  Given inject ($controller, $rootScope) ->
    @scope    = $rootScope.$new()
    @log = @scope.log = jasmine.createSpy("#log")
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
    Given -> @square = @scope.board[@index]

    When  -> @scope.mark(@square)

    Then  -> @square.mark == cross
    And   -> expect(@log).toHaveBeenCalledWith("\u2573a3")

    describe "already marked", ->
      Given -> @square.mark = cross
      Then  -> expect(@log).not.toHaveBeenCalled()

    describe "marked by opponent", ->
      Given -> @square.mark = nought

      Then  -> @square.mark == nought
      And   -> expect(@log).not.toHaveBeenCalled()
