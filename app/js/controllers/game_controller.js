angular.module("app").controller('GameController', function(
  $scope,
  $location,
  AuthenticationService,
  MARKS,
  WINNING_PLAYS) {

  var detectWin, detectStalemate;
  var gameOver = false;
  var currentPlayer = 0;
  var playerMarks = [MARKS.cross, MARKS.nought];
  $scope.player = "Player One";
  $scope.message = playerMarks[currentPlayer] + " to move";

  $scope.board = _.flatten(_.map([3, 2, 1], function(file) {
    return _.map(['a', 'b', 'c'], function(rank) {
      return { id: ''+rank+file };
    });
  }));

  $scope.mark = function(square) {
    if (!gameOver && !square.mark) {
      var mark = playerMarks[currentPlayer];
      square.mark = mark;
      $scope.log(mark + square.id);

      if (detectWin(mark)) {
        $scope.message = "Winner: " + mark;
        gameOver = true;
      } else if (detectStalemate()) {
        $scope.message = "Game Over: It's a Draw";
        gameOver = true;
      } else {
        currentPlayer = ++currentPlayer % 2;
        $scope.message = playerMarks[currentPlayer] + " to move"; // TODO: DRY with a template
      }
    }
  };

  detectWin = function(mark) {
    var mine = _($scope.board).chain().filter(function(square) {
      return square.mark === mark;
    }).map(function(square) {
      return square.id;
    }).value();
    return _(WINNING_PLAYS).detect(function(candidate) {
      return _.intersection(mine, candidate).length === 3;
    });
  };

  /** assumption: winner detection found no winner */
  detectStalemate = function() {
    return !_($scope.board).detect(function(square) {
     return !square.mark; // true if unmarked
    });
  };

  var onLogoutSuccess = function(response) {
    $location.path('/login');
  };

  $scope.logout = function() {
    AuthenticationService.logout().success(onLogoutSuccess);
  };
});
angular.module("app").constant('MARKS', {
  nought: "\u25ef",
  cross: "\u2573"
});
// FIXME: Chrome, Y U NO LIKE EMOJI?
angular.module("app").constant('xxMARKS', {
  nought: "\u2b55",
  cross: "\u274c"
});
angular.module("app").constant('WINNING_PLAYS', [
  ["a3", "b3", "c3"],
  ["a2", "b2", "c2"],
  ["a1", "b1", "c1"],
  ["a3", "a2", "a1"],
  ["b3", "b2", "b1"],
  ["c3", "c2", "c1"],
  ["a3", "b2", "c1"],
  ["c3", "b2", "a1"]
]);
