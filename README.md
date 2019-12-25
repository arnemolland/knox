<img src="https://github.com/arnemolland/knox/blob/master/assets/knox.png?raw=true" alt="knox" style="zoom:1%;float: left;" height="72" />

![knox](https://github.com/arnemolland/knox/workflows/Flutter%20CI/badge.svg) ![pub](https://img.shields.io/pub/v/knox.svg) [![style: pedantic](https://img.shields.io/badge/style-pedantic-9cf)](https://github.com/dart-lang/pedantic) ![license](https://img.shields.io/github/license/arnemolland/knox)

An implementation of HydratedStorage using flutter_secure_storage, which interfaces with Keychain (iOS) and KeyStore (Android)

## Usage

```dart
final knox = await Knox.getInstance();
```

## Example

With HydratedBlocDelegate

```dart
BlocSupervisor.delegate = await KnoxDelegate.build();
```
