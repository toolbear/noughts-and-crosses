angular.module("app").factory('SuggestionService', function(WINNING_PLAYS) {
  var isSubset = function(set, candidate) {
    return _(set).intersection(candidate).length === candidate.length;
  };

  var partitionSquares = function(ourMark, board) {
    return {
      ours: _(board).where({ mark: ourMark }),
      theirs: _(board).select(function(sq) { return sq.mark && sq.mark !== ourMark; }),
      empty: _(board).reject(function(sq) { return sq.mark; })
    };
  };

  var blockOpponentWin = function(ourMark, board) {
    var squares = partitionSquares(ourMark, board);
    // TODO: ZOMG, so many comprehenions!
    var theirs = _(squares.theirs).pluck("id");
    var empty = _(squares.empty).pluck("id");

    var squareToBlock;
    _(WINNING_PLAYS).find(function(winningPlay) {
      return _(winningPlay).find(function(id) {
        if (_(empty).contains(id)) {
          var nearlyWinning = _(winningPlay).without(id);
          if (isSubset(theirs, nearlyWinning)) {
            squareToBlock = { id: id };
          }
        }
        return squareToBlock;
      });
    });
    if (squareToBlock) {
      return _(board).chain().where(squareToBlock).first().value();
    } else {
      return;
    }
  };

  var randomEmptySquare = function(ourMark, board) {
    return _(partitionSquares(ourMark, board).empty).sample();
  };

  return {
    suggestSquare: function(ourMark, board) {
      var strategies = [
        blockOpponentWin,
        randomEmptySquare
      ];
      var suggest;
      _(strategies).find(function(strategy) {
        return suggest = strategy(ourMark, board);
      });
      return suggest;
    },

    // TODO: only exposed for testing :(
    blockOpponentWin: blockOpponentWin
  };
});
