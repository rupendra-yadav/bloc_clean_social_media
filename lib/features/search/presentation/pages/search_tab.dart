import 'package:clean_bloc_wrap/core/utils/colors.dart';
import 'package:clean_bloc_wrap/features/auth/presentation/widgets/textfield_inputs.dart';
import 'package:clean_bloc_wrap/features/profile/presentation/pages/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController _searchController = TextEditingController();
  bool isShowUser = false;
  var query = '';

  void onSearchChanged(String value) {
    setState(() {
      query = value;
      isShowUser = query.isNotEmpty;
    });
  }

  @override
  // void initState() {
  //   super.initState();
  //   _searchController.addListener(onSearchChanged);
  // }
  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: primaryColor,
        title: Padding(
          padding: const EdgeInsets.all(1.0),
          child: TextField(
            onChanged: (value) {
              onSearchChanged(value);
            },
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.pinkAccent),
              ),
              enabled: true,
              enabledBorder: OutlineInputBorder(),
              hintText: "Search",
            ),
          ),
        ),
      ),
      body: isShowUser
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('username', isGreaterThanOrEqualTo: query)
                  .where('username', isLessThanOrEqualTo: '$query\uf8ff')
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final user = snapshot.data!.docs[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfile(uid: user['uid']),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user['photoUrl']),
                        ),
                        title: Text(user['username']),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    );
                  },
                );
              },
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance.collection("posts").get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 3,
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) => Image.network(
                    (snapshot.data! as dynamic).docs[index]['postUrl'],
                    fit: BoxFit.cover,
                  ),
                  staggeredTileBuilder: (index) => StaggeredTile.count(
                    (index % 4 == 0) ? 2 : 1,
                    (index % 4 == 0) ? 2 : 1,
                  ),
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                );
              },
            ),
    );
  }
}
