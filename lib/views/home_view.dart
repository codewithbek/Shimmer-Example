import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shimmer_example/models/helper_model.dart';
import 'package:shimmer_example/service/users_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = -1;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Loading Shimmer",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.cyan,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.cyan,
        items: const [
          Icon(
            CupertinoIcons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            CupertinoIcons.add,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            CupertinoIcons.person_fill,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (index) {},
      ),
      body: FutureBuilder(
        future: UsersApiService.getUsers(),
        builder: (context, AsyncSnapshot<HelperModel> snapshot) {
          if (!snapshot.hasData) {
            return ListView(
              children: List.generate(10, (index) => buildLoading()),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          } else {
            return SmartRefresher(
              controller: refreshController,
              onRefresh: () async {
                await UsersApiService.getUsers();
                refreshController.refreshCompleted();
                setState(() {});
              },
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: List.generate(
                  snapshot.data!.data.length,
                  (index) => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    child: ListTile(
                      trailing: SizedBox(
                        height: 25,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              backgroundColor: selectedIndex == index
                                  ? Colors.cyan
                                  : Colors.pinkAccent),
                          onPressed: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Text(
                            selectedIndex == index ? "Following" : "Follow",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      tileColor: Colors.white,
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFFE6EDEC),
                        backgroundImage:
                            NetworkImage(snapshot.data!.data[index].img),
                        radius: 35,
                      ),
                      title: Text(
                          "${snapshot.data!.data[index].firstName} ${snapshot.data!.data[index].lastName}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        snapshot.data!.data[index].email,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildLoading() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          tileColor: Colors.white,
          leading: CircleAvatar(
            radius: 35,
            child: Shimmer.fromColors(
              baseColor: const Color(0xFFE6EDEC),
              highlightColor: Colors.white70,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE6EDEC),
                ),
              ),
            ),
          ),
          title: Shimmer.fromColors(
            baseColor: const Color(0xFFE6EDEC),
            highlightColor: Colors.white70,
            child: Container(
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFE6EDEC),
              ),
            ),
          ),
          subtitle: Shimmer.fromColors(
            baseColor: const Color(0xFFE6EDEC),
            highlightColor: Colors.white70,
            child: Container(
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFE6EDEC),
              ),
            ),
          ),
        ),
      );
}
