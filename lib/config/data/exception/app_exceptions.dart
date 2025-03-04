class AppExceptions implements Exception {
  final String? message;
  final String? prefix;

  AppExceptions([this.message, this.prefix]);

  @override
  String toString() {
    return '$prefix: $message';
  }
}

class NetworkException extends AppExceptions {
  NetworkException([String? message]) : super(message, 'Network error');
}
class BadRequestException extends AppExceptions {
  BadRequestException([String? message]) : super(message, 'Bad request');
}
class UnauthorizedException extends AppExceptions {
  UnauthorizedException([String? message]) : super(message, 'Unauthorized access');
}


class ApiException extends AppExceptions {
  ApiException([String? message]) : super(message, 'API error');
}

class DataParsingException extends AppExceptions {
  DataParsingException([String? message]) : super(message, 'Data parsing error');
}

class ResponseFormatException extends AppExceptions {
  ResponseFormatException([String? message]) : super(message, 'Invalid response format');
}

class TimeoutException extends AppExceptions {
  TimeoutException([String? message]) : super(message, 'Request timed out');
}

class AuthenticationException extends AppExceptions {
  AuthenticationException([String? message]) : super(message, 'Authentication failed');
}

class AuthorizationException extends AppExceptions {
  AuthorizationException([String? message]) : super(message, 'Authorization error');
}

class NotFoundException extends AppExceptions {
  NotFoundException([String? message]) : super(message, 'Resource not found');
}

class RateLimitExceededException extends AppExceptions {
  RateLimitExceededException([String? message]) : super(message, 'Rate limit exceeded');
}

class ServerException extends AppExceptions {
  ServerException([String? message]) : super(message, 'Server error');
}

class CacheException extends AppExceptions {
  CacheException([String? message]) : super(message, 'Cache error');
}

class ConnectivityException extends AppExceptions {
  ConnectivityException([String? message]) : super(message, 'No connectivity');
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message]) : super(message, 'Error during data fetching');
}

class NoInternetException extends AppExceptions {
  NoInternetException([String? message]) : super(message, 'No internet connection');
}
