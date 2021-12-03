import 'package:flutter/material.dart';
import 'package:journal/blocs/authentication_bloc_provider.dart';
import 'package:journal/blocs/home_bloc.dart';
import 'package:journal/blocs/authentication_bloc.dart';
import 'package:journal/blocs/home_bloc_provider.dart';
import 'package:journal/blocs/journal_entry_bloc_provider.dart';
import 'package:journal/blocs/journal_entry_bloc.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/models/mood_icons.dart';
import 'package:journal/pages/edit_entry.dart';
import 'package:journal/services/db_firestore.dart';
import 'package:journal/utils/format_dates.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AuthenticationBloc _authenticationBloc;
  late HomeBloc _homeBloc;
  late String _uid;
  final List<MoodIcon> _moodIcons = MoodIcon.list;
  FormatDates _formatDates = FormatDates();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authenticationBloc =
        AuthenticationBlocProvider.of(context).authenticationBloc;
    _homeBloc = HomeBlocProvider.of(context).homeBloc;
    _uid = HomeBlocProvider.of(context).uid;
  }

  @override
  void dispose() {
    _homeBloc.dispose();
    super.dispose();
  }

  // Add or Edit Journal Entry and call the Show Entry Dialog
  void _addOrEditJournal({required bool add, required Journal journal}) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) {
            return JournalEntryBlocProvider(
              journalEntryBloc:
                  JournalEntryBloc(add, journal, DbFirestoreService()),
              child: const EditEntry(),
            );
          },
          fullscreenDialog: true),
    );

    // Confirm deleting a journal entry
    Future<bool> _confirmDeleteJournal() async {
      return await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Delete Journal'),
              content: const Text('Are you sure you would like to Delete?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('CANCEL'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text(
                    'DELETE',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.lightGreen.shade800),
        ),
        elevation: 0.0,
        bottom: PreferredSize(
          child: Container(),
          preferredSize: const Size.fromHeight(32.0),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightGreen, Colors.lightGreen.shade50],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _authenticationBloc.logoutUser.add(true);
            },
            icon: const Icon(Icons.exit_to_app),
            color: Colors.lightGreen.shade800,
          ),
        ],
      ),
      body: Center(
        child: Container(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Journal Entry',
        backgroundColor: Colors.lightGreen.shade300,
        child: const Icon(Icons.add),
        onPressed: () async {
          // TODO: Add _addOrEditJournal method
        },
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        child: Container(
          height: 44.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightGreen.shade50, Colors.lightGreen],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }
}
