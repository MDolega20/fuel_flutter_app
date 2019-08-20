// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

// ignore: unnecessary_new
final messages = new MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'messages';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "cost" : MessageLookupByLibrary.simpleMessage("cost"),
    "dateTime" : MessageLookupByLibrary.simpleMessage("date and time"),
    "fueling" : MessageLookupByLibrary.simpleMessage("tankowanie"),
    "fullFueling" : MessageLookupByLibrary.simpleMessage("full fueling"),
    "litres" : MessageLookupByLibrary.simpleMessage("litres"),
    "noEnoughData" : MessageLookupByLibrary.simpleMessage("not enough data"),
    "odometr" : MessageLookupByLibrary.simpleMessage("odometr"),
    "price" : MessageLookupByLibrary.simpleMessage("price"),
    "startText" : MessageLookupByLibrary.simpleMessage("Welcome in my new fuel app"),
    "state" : MessageLookupByLibrary.simpleMessage("state"),
    "title" : MessageLookupByLibrary.simpleMessage("Fuel app")
  };
}
