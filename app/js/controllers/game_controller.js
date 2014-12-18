angular.module("app").controller('GameController', function($scope, $location, AuthenticationService, MARKS) {

  $scope.player = "Player One";
  $scope.message = MARKS.cross + " to move";

  $scope.board = _.flatten(_.map([3, 2, 1], function(file) {
    return _.map(['a', 'b', 'c'], function(rank) {
      return { id: ''+rank+file };
    });
  }));

  $scope.mark = function(square) {
    if (!square.mark) {
      var mark = MARKS.cross;
      square.mark = mark;
      $scope.log(mark + square.id);
    }
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
