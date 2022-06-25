import 'package:bloxman/contact/domain/model/contact_model.dart';
import 'package:bloxman/contact/presentation/bloc/contact_bloc.dart';
import 'package:bloxman/core/provider/bloc_provider.dart';
import 'package:bloxman/core/widgets/card_widget.dart';
import 'package:bloxman/core/widgets/circle_widget.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ContactBloc _bloc = BlocProvider.of<ContactBloc>(context);

    return StreamBuilder<List<ContactModel>>(
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
                    padding: EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){},
                        borderRadius: BorderRadius.circular(5),
                        child: ListTile(
                          leading: snapshot.data![index].selected
                              ? Checkbox(
                            value: snapshot.data![index].selected,
                            onChanged: (value) {
                              _bloc.updateSelection(index);
                            },
                          )
                              : CircleWidget(builder: (_) => Icon(
                            Icons.person_outline,
                            size: 24,
                            color: Colors.white,
                          ),),
                          selected: snapshot.data![index].selected,
                          title: Text(snapshot.data![index].displayName),
                          subtitle: Text(snapshot.data![index].phone),
                          trailing: IconButton(
                            onPressed: () async {
                              // add contact to block list
                              String message = await _bloc.addToBlock(index);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(message),
                              ));
                            },
                            icon: const Icon(
                              Icons.block,
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text("Add Contacts"),
                  );
        }
      },
      stream: _bloc.contactStream,
    );
  }
}
