import 'package:bloxman/blockedList/presentation/bloc/blocked_bloc.dart';
import 'package:bloxman/blockedList/presentation/ui/blocked_page.dart';
import 'package:bloxman/collection/presentation/bloc/collection_bloc.dart';
import 'package:bloxman/collection/presentation/ui/collection_page.dart';
import 'package:bloxman/contact/presentation/bloc/contact_bloc.dart';
import 'package:bloxman/contact/presentation/ui/contact_page.dart';
import 'package:bloxman/core/provider/bloc_provider.dart';
import 'package:bloxman/home/presentation/bloc/home_bloc.dart';
import 'package:bloxman/home/presentation/widgets/add_block_contact_bottom_sheet.dart';
import 'package:bloxman/settings/presentation/ui/settings_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeBloc _bloc = BlocProvider.of<HomeBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      appBar: AppBar(
        title: const Text("Blox"),
        titleSpacing: 25,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {

            },
            icon: Icon(Icons.search),
            padding: EdgeInsets.only(
              right: 25,
            ),
          ),
          IconButton(
            onPressed: () {
              _bloc.updateBottomNavIndex(2);
            },
            icon: Icon(Icons.settings),
            padding: EdgeInsets.only(
              right: 25,
            ),
          ),
        ],
      ),
      body: StreamBuilder<int>(
        builder: (context, snapshot) {
          switch (snapshot.data) {
            case 0:
              return BlocProvider(
                  child: const ContactPage(), bloc: ContactBloc());
            case 1:
              return BlocProvider(
                  child: CollectionPage(), bloc: CollectionBloc());
            case 2:
              return SettingsPage(
                blockListCallback: (index) {
                  _bloc.updateBottomNavIndex(index);
                },
              );
            case 3:
              return BlocProvider(
                  child: BlockedPage(), bloc: BlockedBloc());
            default:
              return Container();
          }
        },
        stream: _bloc.bottomNavIndexStream,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AddBlockContactBottomSheet(
            topIcon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            message: "Add Contact",
            onAddClosing: () {

            },
            onSubmit: (c) {
              Navigator.pop(c);
            },
            controller: TextEditingController(),
          ).show(
            context: context,
            isDismissible: false,
          );
        },
        child: const Icon(
          Icons.person_add_outlined,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: StreamBuilder<int>(
        builder: (context, snapshot) => Container(
          decoration: new BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.5),
                blurRadius: 5.0, // soften the shadow
                spreadRadius: 0.0, //extend the shadow
                offset: Offset(
                  0.0, // Move to right 10  horizontally
                  -0.6, // Move to bottom 10 Vertically
                ),
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.contacts),
                  label: "Contacts",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.library_books),
                  label: "Collections",
                ),
              ],
              backgroundColor: Colors.transparent,
              elevation: 0,
              currentIndex: snapshot.hasData && snapshot.data! < 2 ? snapshot.data! : 0,
              onTap: (index) {
                _bloc.updateBottomNavIndex(index);
              },
            ),
          ),
        ),
        stream: _bloc.bottomNavIndexStream,
      ),
    );
  }
}
