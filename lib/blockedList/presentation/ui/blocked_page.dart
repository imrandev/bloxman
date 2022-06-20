import 'package:bloxman/blockedList/domain/model/blocked_model.dart';
import 'package:bloxman/blockedList/presentation/bloc/blocked_bloc.dart';
import 'package:bloxman/core/provider/bloc_provider.dart';
import 'package:flutter/material.dart';

class BlockedPage extends StatelessWidget {
  const BlockedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlockedBloc _bloc = BlocProvider.of<BlockedBloc>(context);

    return StreamBuilder<List<BlockedModel>>(
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.none:
            return const Center(
              child: Text("Add Contacts"),
            );
          case ConnectionState.done:
          case ConnectionState.active:
            return snapshot.hasData &&
                    snapshot.data != null &&
                    snapshot.data!.isNotEmpty
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.contacts),
                          title: Text(snapshot.data![index].phone!),
                          trailing: IconButton(
                            onPressed: () async {
                              // remove contact to block list
                              String message = await _bloc
                                  .removeFromBlock(snapshot.data![index]);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(message),
                              ));
                            },
                            icon: const Icon(
                              Icons.remove_circle_outline,
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text("Blocked Contacts"),
                  );
        }
      },
      stream: _bloc.contactStream,
    );
  }
}
