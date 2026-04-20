# flutter_simple_cache

A small in-memory cache utility for Flutter apps.

This package was built for internal use to avoid repeating the same caching logic across multiple projects. It keeps things simple and focuses on basic use cases.

## Features

- Simple key-value storage
- Generic type support
- Optional TTL (time-based expiry)
- Manual remove and clear
- Lightweight and dependency-free

## Usage

Initialize once at app start:

```dart
void main() {
  FlutterSimpleCache.init(
    defaultTtl: Duration(minutes: 5),
    maxEntries: 100,
  );

  runApp(MyApp());
}