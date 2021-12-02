import 'package:flutter/cupertino.dart';
import 'package:journal/blocs/journal_entry_bloc.dart';

class JournalEntryBlocProvider extends InheritedWidget {
  final JournalEntryBloc journalEntryBloc;

  const JournalEntryBlocProvider({
    Key? key,
    required Widget child,
    required this.journalEntryBloc,
  }) : super(key: key, child: child);

  static JournalEntryBlocProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType(
        aspect: JournalEntryBlocProvider) as JournalEntryBlocProvider;
  }

  @override
  bool updateShouldNotify(JournalEntryBlocProvider oldWidget) {
    return false;
  }
}
