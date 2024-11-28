import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
 import 'package:flutter/material.dart';
import 'package:media_player_app/screen/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

class PlayListScreen extends StatefulWidget {
  const PlayListScreen({super.key});

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> with TickerProviderStateMixin{
  late HomeProvider hRead;
  late HomeProvider hWatch;
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
     super.initState();
  }

  @override
  void dispose() {
    tabController?.dispose();
     super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    hRead = context.read<HomeProvider>();
    hWatch = context.watch<HomeProvider>();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text("PLAY LIST",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),

        bottom:   TabBar(
          controller: tabController,
            tabs: const [
              Tab(
                icon: Icon(
                  Icons.music_note,
                  color: Colors.greenAccent,
                ),
                text: 'Audio',
              ),
              Tab(
                icon: Icon(
                  Icons.video_collection,
                  color: Colors.greenAccent,
                ),
                text: 'Video',
              ),
            ],
        ),
      ),
      // body: CarouselSlider(
      //   options: CarouselOptions(
      //     height: 350,
      //     autoPlay: true,
      //     autoPlayInterval: const Duration(seconds: 2),
      //     autoPlayAnimationDuration: const Duration(seconds: 1),
      //     autoPlayCurve: Curves.easeOut,
      //     enlargeCenterPage: true,
      //     viewportFraction: 0.8,
      //     enableInfiniteScroll: true,
      //   ),
      //   items: List.generate(
      //     hRead.listOfSong.length,
      //         (index) {
      //       return Stack(
      //         alignment: Alignment.bottomCenter,
      //         children: [
      //            Container(
      //             margin: const EdgeInsets.only(top: 22),
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(18),
      //             ),
      //             child: ClipRRect(
      //               borderRadius: BorderRadius.circular(22),
      //               child: Image.network(hWatch.listOfSong[index]['image']!,
      //                 fit: BoxFit.cover,
      //               ),
      //             ),
      //           ),
      //            Positioned(
      //             bottom: -10, // Adjust position if needed
      //             child: Container(
      //               width: 40,
      //               height: 40,
      //               decoration: BoxDecoration(
      //                 shape: BoxShape.circle,
      //                 color: Colors.blue.withOpacity(0.8),
      //                 border: Border.all(
      //                   color: Colors.white,
      //                   width: 3,
      //                 ),
      //               ),
      //               alignment: Alignment.center,
      //               child: Text(
      //                 '${index + 1}',
      //                 style: const TextStyle(
      //                   color: Colors.white,
      //                   fontSize: 20,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ],
      //       );
      //     },
      //   ),
      // ),

      body: Padding(
        padding: const EdgeInsets.all(18),
      child: TabBarView(
        controller: tabController,
        children:[
          ListView.builder(
          itemCount: hRead.listOfSong.length,
          itemBuilder: (context, index) {
            final song = hRead.listOfSong[index];
            return GestureDetector(
              onTap: () {
                hRead.playSong(index);
                Navigator.pushNamed(context, 'home',arguments: hWatch.listOfSong[index]);
              },
              child: Container(
                margin: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 2,
                      offset: const Offset(4, 3),
                    ),
                    const BoxShadow(
                      color: Colors.white,
                      blurRadius: 10,
                      offset: Offset(-6, 6),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(28),
                  title: Text(
                    song['title']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    song['subtitle'] ?? "No subtitle available",
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.music_note,
                    color: Colors.black,
                    size: 28,
                  ),
                  leading: Container(
                    height: 80,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: hRead.listOfSong[index]['image']!,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.broken_image,
                        color: Colors.red,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),

                ),
              ),
            );
          },
        ),

          // video list
          Column(
            children: [
              if (hWatch.isVideoInitialized)
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Chewie(
                    controller: hWatch.chewieController!,
                  ),
                )
              else
                const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
      ),
    );
  }
}