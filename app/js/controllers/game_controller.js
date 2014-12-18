angular.module("app").controller('GameController', function($scope, $location, AuthenticationService) {
  $scope.title = "Game";
  $scope.message = "Game on!";

  var onLogoutSuccess = function(response) {
    $location.path('/login');
  };

  $scope.logout = function() {
    AuthenticationService.logout().success(onLogoutSuccess);
  };
});
