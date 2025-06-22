import 'package:clean_bloc_wrap/core/utils/colors.dart';
import 'package:clean_bloc_wrap/features/auth/presentation/widgets/textfield_inputs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit, size: 25)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFieldInputs(
                hintText: 'Search',
                textEditingController: _searchController,
                textInputKeyBoardType: TextInputType.emailAddress,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Messages", style: TextStyle(fontSize: 18)),
                    GestureDetector(
                      child: Text(
                        "Requests",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //CHATS SECTION
              const SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: [Chats(), Chats(), Chats(), Chats()]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        child: ListTile(
          leading: CircleAvatar(radius: 26, backgroundColor: blueColor),
          title: Text("Users"),
          subtitle: Text("message"),
          trailing: Icon(Icons.camera_alt_outlined),
        ),
      ),
    );
  }
}

class StatusIndicator extends StatelessWidget {
  const StatusIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        children: [
          CircleAvatar(backgroundColor: Colors.red, radius: 40),
          Positioned(
            bottom: -2,
            left: 50,
            child: Icon(Icons.donut_small_rounded, color: Colors.lightGreen),
          ),
        ],
      ),
    );
  }
}
