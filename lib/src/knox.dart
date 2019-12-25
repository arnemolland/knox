import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

/// Implementation of [HydratedStorage] which uses `PathProvider` and `Hive`
/// to persist and retrieve state changes from the local device.
class Knox implements HydratedStorage {
  static Knox _instance;
  final FlutterSecureStorage _storage;

  /// Returns an instance of [Knox].
  static Future<Knox> getInstance() async {
    if (_instance != null) {
      return _instance;
    }

    final storage = const FlutterSecureStorage();

    _instance = Knox._(storage);
    return _instance;
  }

  Knox._(this._storage);

  @override
  Future<void> clear({AndroidOptions androidOptions, iOSOptions iOSOptions}) async {
    return await _storage.deleteAll(
      aOptions: androidOptions,
      iOptions: iOSOptions,
    );
  }

  @override
  Future<void> delete(String key, {AndroidOptions androidOptions, iOSOptions iOSOptions}) {
    return _storage.delete(
      key: key,
      aOptions: androidOptions,
      iOptions: iOSOptions,
    );
  }

  @override
  Future<String> read(String key, {AndroidOptions androidOptions, iOSOptions iOSOptions}) async {
    return _storage
        .read(
          key: key,
          aOptions: androidOptions,
          iOptions: iOSOptions,
        )
        .then((value) => value);
  }

  @override
  Future<void> write(String key, dynamic value,
      {AndroidOptions androidOptions, iOSOptions iOSOptions}) {
    return _storage.write(
      key: key,
      value: value is String ? value : jsonEncode(value),
      aOptions: androidOptions,
      iOptions: iOSOptions,
    );
  }
}
