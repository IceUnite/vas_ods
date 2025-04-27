import 'dart:async';


import 'package:dio/dio.dart';

import '../../core/model/log_model.dart';
import '../../core/model/network_log_model.dart';



class MadInspector {
  static final MadInspectorNetworkModule _madInspectorNetworkModule = MadInspectorNetworkModule();

  static MadInspectorNetworkModule get network =>
      _madInspectorNetworkModule;

  static final MadInspectorLogger _madInspectorLogger = MadInspectorLogger();

  static MadInspectorLogger get log =>
      _madInspectorLogger;

}

enum StatusFilterEnum {
  informational,
  successful,
  redirection,
  clientError,
  serverError,
}

enum MethodEnum {
  get,
  post,
  put,
  patch,
  delete,
}

class MadInspectorNetworkModule {
  static final List<NetworkLogModel> _networkResponses = <NetworkLogModel>[];
  static List<NetworkLogModel> get networkResponses => _networkResponses;
  static final List<NetworkLogModel> _filteredNetworkResponses = <NetworkLogModel>[];
  static List<NetworkLogModel> get filteredNetworkResponses => _filteredNetworkResponses;
  static final Set<StatusFilterEnum> _statusFilterMap = <StatusFilterEnum>{
    StatusFilterEnum.informational,
    StatusFilterEnum.successful,
    StatusFilterEnum.redirection,
    StatusFilterEnum.clientError,
    StatusFilterEnum.serverError,
  };
  static Set<StatusFilterEnum> get statusFilterMap => _statusFilterMap;
  static final Set<MethodEnum> _methodFilterMap = <MethodEnum>{
    MethodEnum.get,
    MethodEnum.post,
    MethodEnum.put,
    MethodEnum.patch,
    MethodEnum.delete,
  };
  static Set<MethodEnum> get methodFilterMap => _methodFilterMap;

  static String _searchQuery = '';

  static final StreamController<void> _updateStreamController = StreamController<void>.broadcast();
  static Stream<void> updateStream() => _updateStreamController.stream;

  static void updateFilteredElements() {
    _filteredNetworkResponses.clear();
    _filteredNetworkResponses.addAll(List<NetworkLogModel>.from(_networkResponses));
    if (_searchQuery.isNotEmpty) {
      _filteredNetworkResponses.removeWhere(
              (NetworkLogModel element) => !(element.requestUrl?.toLowerCase() ?? '').contains(_searchQuery)
      );
    }
    if (!_statusFilterMap.contains(StatusFilterEnum.informational)) {
      _filteredNetworkResponses.removeWhere(
              (NetworkLogModel element) => (element.statusCode ?? 0) >= 100 && (element.statusCode ?? 0) <= 199
      );
    }
    if (!_statusFilterMap.contains(StatusFilterEnum.successful)) {
      _filteredNetworkResponses.removeWhere(
              (NetworkLogModel element) => (element.statusCode ?? 0) >= 200 && (element.statusCode ?? 0) <= 299
      );
    }
    if (!_statusFilterMap.contains(StatusFilterEnum.redirection)) {
      _filteredNetworkResponses.removeWhere(
              (NetworkLogModel element) => (element.statusCode ?? 0) >= 300 && (element.statusCode ?? 0) <= 399
      );
    }
    if (!_statusFilterMap.contains(StatusFilterEnum.clientError)) {
      _filteredNetworkResponses.removeWhere(
              (NetworkLogModel element) => (element.statusCode ?? 0) >= 400 && (element.statusCode ?? 0) <= 499
      );
    }
    if (!_statusFilterMap.contains(StatusFilterEnum.serverError)) {
      _filteredNetworkResponses.removeWhere(
              (NetworkLogModel element) => (element.statusCode ?? 0) >= 500 && (element.statusCode ?? 0) <= 599
      );
    }

    if (!_methodFilterMap.contains(MethodEnum.get)) {
      _filteredNetworkResponses.removeWhere(
              (NetworkLogModel element) => element.httpMethod?.toLowerCase() == 'get'
      );
    }
    if (!_methodFilterMap.contains(MethodEnum.post)) {
      _filteredNetworkResponses.removeWhere(
              (NetworkLogModel element) => element.httpMethod?.toLowerCase() == 'post'
      );
    }
    if (!_methodFilterMap.contains(MethodEnum.put)) {
      _filteredNetworkResponses.removeWhere(
              (NetworkLogModel element) => element.httpMethod?.toLowerCase() == 'put'
      );
    }
    if (!_methodFilterMap.contains(MethodEnum.patch)) {
      _filteredNetworkResponses.removeWhere(
              (NetworkLogModel element) => element.httpMethod?.toLowerCase() == 'patch'
      );
    }
    if (!_methodFilterMap.contains(MethodEnum.delete)) {
      _filteredNetworkResponses.removeWhere(
              (NetworkLogModel element) => element.httpMethod?.toLowerCase() == 'delete'
      );
    }
  }

  static void addElementToFiltered(NetworkLogModel elementToAdd) {
    if (_searchQuery.isNotEmpty && elementToAdd.requestUrl?.toLowerCase().contains(_searchQuery.toLowerCase()) != true) return;

    if (!_statusFilterMap.contains(StatusFilterEnum.informational) &&
        (elementToAdd.statusCode ?? 0) >= 100 && (elementToAdd.statusCode ?? 0) <= 199) {
      return;
    }

    if (!_statusFilterMap.contains(StatusFilterEnum.successful) &&
        (elementToAdd.statusCode ?? 0) >= 200 && (elementToAdd.statusCode ?? 0) <= 299) {
      return;
    }

    if (!_statusFilterMap.contains(StatusFilterEnum.redirection) &&
        (elementToAdd.statusCode ?? 0) >= 300 && (elementToAdd.statusCode ?? 0) <= 399) {
      return;
    }

    if (!_statusFilterMap.contains(StatusFilterEnum.clientError) &&
        (elementToAdd.statusCode ?? 0) >= 400 && (elementToAdd.statusCode ?? 0) <= 499) {
      return;
    }

    if (!_statusFilterMap.contains(StatusFilterEnum.serverError) &&
        (elementToAdd.statusCode ?? 0) >= 500 && (elementToAdd.statusCode ?? 0) <= 599) {
      return;
    }

    if (!_methodFilterMap.contains(MethodEnum.get) &&
        elementToAdd.httpMethod?.toLowerCase() == 'get') {
      return;
    }

    if (!_methodFilterMap.contains(MethodEnum.post) &&
        elementToAdd.httpMethod?.toLowerCase() == 'post') {
      return;
    }

    if (!_methodFilterMap.contains(MethodEnum.put) &&
        elementToAdd.httpMethod?.toLowerCase() == 'put') {
      return;
    }

    if (!_methodFilterMap.contains(MethodEnum.put) &&
        elementToAdd.httpMethod?.toLowerCase() == 'patch') {
      return;
    }

    if (!_methodFilterMap.contains(MethodEnum.delete) &&
        elementToAdd.httpMethod?.toLowerCase() == 'delete') {
      return;
    }

    _filteredNetworkResponses.insert(0, elementToAdd);
  }

  static void setQuery(String newQuery) {
    _searchQuery = newQuery.toLowerCase();
    updateFilteredElements();
    _updateStreamController.add(null);
  }

  static void removeStatusFromFilter(StatusFilterEnum filterToRemove) {
    statusFilterMap.remove(filterToRemove);
    updateFilteredElements();
    _updateStreamController.add(null);
  }

  static void addStatusToFilter(StatusFilterEnum filterToAdd) {
    statusFilterMap.add(filterToAdd);
    updateFilteredElements();
    _updateStreamController.add(null);
  }

  static void removeMethodFromFilter(MethodEnum filterToRemove) {
    methodFilterMap.remove(filterToRemove);
    updateFilteredElements();
    _updateStreamController.add(null);
  }

  static void addMethodToFilter(MethodEnum filterToAdd) {
    methodFilterMap.add(filterToAdd);
    updateFilteredElements();
    _updateStreamController.add(null);
  }

  Interceptor dioInterceptor() => const MadInspectorDioInterceptor();
}

class MadInspectorDioInterceptor extends Interceptor {
  const MadInspectorDioInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    try {
      if (err.response != null) {
        final NetworkLogModel elementToAdd = NetworkLogModel(
          statusCode: err.response?.statusCode,
          httpMethod: err.response?.requestOptions.method,
          requestUrl: err.response?.requestOptions.uri.toString(),
          timestamp: DateTime.now().toIso8601String(),
          requestHeaders: err.response?.requestOptions.headers.toString(),
          requestBody: '${err.response?.requestOptions.data}',
          responseHeaders: err.response?.headers.toString(),
          responseBody: err.response?.data.toString(),
        );
        MadInspectorNetworkModule.networkResponses.insert(0, elementToAdd);
        MadInspectorNetworkModule.addElementToFiltered(elementToAdd);
      }
    } catch(_) {}

    handler.next(err);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    try {
      final NetworkLogModel elementToAdd = NetworkLogModel(
        statusCode: response.statusCode,
        httpMethod: response.requestOptions.method,
        requestUrl: response.requestOptions.uri.toString(),
        timestamp: DateTime.now().toIso8601String(),
        requestHeaders: response.requestOptions.headers.toString(),
        requestBody: '${response.requestOptions.data}',
        responseHeaders: response.headers.toString(),
        responseBody: response.data.toString(),
      );
      MadInspectorNetworkModule.networkResponses.insert(0, elementToAdd);
      MadInspectorNetworkModule.addElementToFiltered(elementToAdd);
    } catch(_) {}

    handler.next(response);
  }
}

class MadInspectorLogger {
  static final List<LogModel> _logs = <LogModel>[];
  static List<LogModel> get logs => _logs;

  void d(String name, Object? details, StackTrace? stackTrace) {
    MadInspectorLogger.logs.add(
        LogModel(
            name: name,
            details: details,
            stackTrace: stackTrace,
            type: 'Debug',
            timestamp: DateTime.now().toIso8601String()
        )
    );
  }

  void i(String name, Object? details, StackTrace? stackTrace) {
    MadInspectorLogger.logs.add(
        LogModel(
            name: name,
            details: details,
            stackTrace: stackTrace,
            type: 'Info',
            timestamp: DateTime.now().toIso8601String()
        )
    );
  }

  void w(String name, Object? details, StackTrace? stackTrace) {
    MadInspectorLogger.logs.add(
        LogModel(
            name: name,
            details: details,
            stackTrace: stackTrace,
            type: 'Info',
            timestamp: DateTime.now().toIso8601String()
        )
    );
  }

  void e(String name, Object? details, StackTrace? stackTrace) {
    MadInspectorLogger.logs.add(
        LogModel(
            name: name,
            details: details,
            stackTrace: stackTrace,
            type: 'Error',
            timestamp: DateTime.now().toIso8601String()
        )
    );
  }

  void f(String name, Object? details, StackTrace? stackTrace) {
    MadInspectorLogger.logs.add(
        LogModel(
            name: name,
            details: details,
            stackTrace: stackTrace,
            type: 'Fatal',
            timestamp: DateTime.now().toIso8601String()
        )
    );
  }
}

