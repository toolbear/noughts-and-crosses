angular.module("app").config(function($routeProvider, $locationProvider) {

  $locationProvider.html5Mode(true);

  $routeProvider.when('/login', {
    templateUrl: 'login.html',
    controller: 'LoginController'
  });

  $routeProvider.when('/game', {
    templateUrl: 'game.html',
    controller: 'GameController'
  });

  $routeProvider.otherwise({ redirectTo: '/login' });

});
