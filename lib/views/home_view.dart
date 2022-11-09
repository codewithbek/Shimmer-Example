import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shimmer_example/models/helper_model.dart';
import 'package:shimmer_example/service/users_service.dart';
import 'package:shimmer_example/widgets/shimmer_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shimmer Loading Animation"),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        leading: IconButton(
          icon: const Icon(Icons.menu),
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
        onTap: (index) {
          //Handle button tap
        },
      ),
      body: FutureBuilder(
        future: UsersApiService.getUsers(),
        builder: (context, AsyncSnapshot<HelperModel> snapshot) {
          if (!snapshot.hasData) {
            return ListView.builder(
                itemCount: 12,
                itemBuilder: (context, index) {
                  return buildUsersShimmer();
                });
          } else if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          } else {
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: List.generate(
                snapshot.data!.data.length,
                (index) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage:
                            NetworkImage(snapshot.data!.data[index].img),
                        radius: 30,
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${snapshot.data!.data[index].firstName} ${snapshot.data!.data[index].lastName}",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text(
                            "Email: ${snapshot.data!.data[index].email}",
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildUsersShimmer() => ListTile(
        leading: Shimmer.fromColors(
          baseColor: Theme.of(context).splashColor,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.width * 0.2,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.blueGrey),
          ),
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: ShimmerWidget.rectangular(
            height: 16,
            width: MediaQuery.of(context).size.width * 0.3,
          ),
        ),
        subtitle: const ShimmerWidget.rectangular(height: 14),
      );
}
