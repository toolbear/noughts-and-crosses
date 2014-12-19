describe "service: SuggestionService", ->

  Given -> module("app")

  Given -> inject (WINNING_PLAYS, @SuggestionService) =>
    WINNING_PLAYS.splice(
      0,
      WINNING_PLAYS.length,
      ["a", "b"],
      ["b", "c"])

  Given ->
    @board = [
      { id: "a" }
      { id: "b" }
      { id: "c" }
    ]

  describe "#blockOpponentWin", ->
    Given -> @blockOpponentWin = @SuggestionService.blockOpponentWin
    When  -> @suggestion = @blockOpponentWin("O", @board)
    Then  -> expect(@suggestion).toBeUndefined()

    describe "opponent one move from winning #1", ->
      Given -> @board[0].mark = "X"
      Then  -> expect(@suggestion).toBe(@board[1])

      describe "already blocked", ->
       Given -> @board[1].mark = "O";
       Then  -> expect(@suggestion).toBeUndefined()

    describe "opponent one move from winning #2", ->
      Given -> @board[2].mark = "X"
      Then  -> expect(@suggestion).toBe(@board[1])
