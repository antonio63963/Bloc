import 'package:bloc_auth/models.dart';
import 'package:flutter/material.dart' show immutable;

@immutable
abstract interface class NotesApiProtocol {
  Future<Iterable<Note>?> getNotes({required LoginHandle loginHandle});
}

@immutable
class NotesApi implements NotesApiProtocol {
  @override
  Future<Iterable<Note>?> getNotes({required LoginHandle loginHandle}) =>
      Future.delayed(
        const Duration(seconds: 2),
        () => loginHandle == const LoginHandle.fooBar() ? mockNotes : null,
      );
}
