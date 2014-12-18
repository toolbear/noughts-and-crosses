angular.module("app").controller('GameController', function($scope, $location, AuthenticationService) {
  // FIXME: Chrome, Y U NO LIKE EMOJI?
  //var nought = '\u2b55';
  //var cross = '\u274c';
  var nought = '\u25ef';
  var cross = '\u2573';

  $scope.player = "Player One";
  $scope.message = cross + " to move";

  // TODO: these probably don't need to be exposed
  $scope.nought = nought;
  $scope.cross = cross;

  $scope.board = _.flatten(_.map([3, 2, 1], function(file) {
    return _.map(['a', 'b', 'c'], function(rank) {
      return { id: ''+rank+file };
    });
  }));

  $scope.mark = function(square) {
    square.mark = cross;
  };

  var onLogoutSuccess = function(response) {
    $location.path('/login');
  };

  $scope.logout = function() {
    AuthenticationService.logout().success(onLogoutSuccess);
  };
});
