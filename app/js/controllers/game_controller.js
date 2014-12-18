angular.module("app").controller('GameController', function($scope, $location, AuthenticationService) {
  // FIXME: Chrome, Y U NO LIKE EMOJI?
  //var nought = '\u2b55';
  //var cross = '\u274c';
  var nought = '\u25ef';
  var cross = '\u2573';

  $scope.player = "Player One";
  $scope.message = cross + " to move";
  $scope.nought = nought;
  $scope.cross = cross;

  var onLogoutSuccess = function(response) {
    $location.path('/login');
  };

  $scope.logout = function() {
    AuthenticationService.logout().success(onLogoutSuccess);
  };
});
