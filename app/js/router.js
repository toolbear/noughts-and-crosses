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

  $routeProvider.when('/$resource/list-of-books', {
    templateUrl: 'books_resource.html',
    controller: 'BooksResourceController'
  });

  $routeProvider.when('/$http/list-of-books', {
    templateUrl: 'books_http.html',
    controller: 'BooksHttpController',
    resolve: {
      books: function(BookService) {
        return BookService.getBooks();
      }
    }
  });

  $routeProvider.otherwise({ redirectTo: '/login' });

});
