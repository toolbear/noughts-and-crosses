angular.module("app").controller('GameController', function($scope, $location, AuthenticationService) {
  var nought = '\u2b55';
  var cross = '\u274c';

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
