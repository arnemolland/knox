import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:knox/knox.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  group('knox', () {
    final mockStorage = {};
    const channel = MethodChannel('plugins.it_nomads.com/flutter_secure_storage');

    Knox knox;

    channel.setMockMethodCallHandler((call) async {
      switch (call.method) {
        case 'write':
          return mockStorage.addAll({
            call.arguments['key']: call.arguments['value'],
          });
        case 'read':
          return mockStorage[call.arguments['key']];
        case 'delete':
          return mockStorage.remove(call.arguments['key']);
        case 'deleteAll':
          return mockStorage.clear();
      }
    });

    tearDown(() => knox.clear());

    group('read', () {
      test('returns null when file does not exist', () async {
        knox = await Knox.getInstance();
        expect(await knox.read('MockBloc'), isNull);
      });

      test('returns null value when corrupt', () async {
        knox = await Knox.getInstance();
        await knox.write('invalid', 'value');
        expect(await knox.read('MockBloc'), isNull);
      });
    });

    group('write', () {
      test('writes value', () async {
        knox = await Knox.getInstance();
        await knox.write('MockBloc', {'state': 1});
        expect(jsonDecode(await knox.read('MockBloc'))['state'] as int, 1);
      });
    });

    group('clear', () {
      test('calls deletes file, clears storage and resets instance', () async {
        knox = await Knox.getInstance();
        await knox.write('MockBloc', {'state': 1});
        expect(jsonDecode(await knox.read('MockBloc')), {'state': 1});

        await knox.clear();
        expect(await knox.read('MockBloc'), isNull);

        expect(mockStorage, isEmpty);
      });
    });

    group('delete', () {
      test('does nothing for non-existing key value pair', () async {
        knox = await Knox.getInstance();

        expect(await knox.read('MockBloc'), null);
        await knox.delete('MockBloc');
        expect(await knox.read('MockBloc'), isNull);
      });

      test('deletes existing key value pair', () async {
        knox = await Knox.getInstance();

        await knox.write('MockBloc', {'state': 1});
        expect(jsonDecode(await knox.read('MockBloc')), {'state': 1});

        await knox.delete('MockBloc');
        expect(await knox.read('MockBloc'), isNull);
      });
    });
  });
}
