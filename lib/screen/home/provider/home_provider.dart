import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chewie/chewie.dart';
 import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomeProvider with ChangeNotifier {

  List<Map<String,String>> listOfSong = [
    {
      'title' : "Rabba Mereya",
      'image' : "https://i1.sndcdn.com/artworks-O3GS5h82Umt1sgSx-1z9tUQ-t500x500.jpg",
      'url' : "https://pagalfree.com/musics/128-Rabba Mereya - B Praak 128 Kbps.mp3",
      'subtitle' : "B Praak, Avvy Sra, Jaani"
    },
     {
      'title' : "Singham Again",
      'image' : "https://s.saregama.tech/image/c/fh_200/e/2b/cf/singham-again_title-track_ott_1440_1729858521.jpg",
      'url' : "https://pagalfree.com/musics/128-Singham Again Title Track - Singham Again 128 Kbps.mp3",
      'subtitle' : "Swanand Kirkire, Santhosh, Ravi Basrur"
    },

     {
      'title' : "Bhool Bhulaiyaa 3",
      'image' : "https://c.saavncdn.com/443/Bhool-Bhulaiyaa-3-Hindi-2024-20241108131003-500x500.jpg",
      'url' : "https://pagalfree.com/musics/128-Bhool Bhulaiyaa 3 - Title Track (Feat. Pitbull) - Bhool Bhulaiyaa 3 128 Kbps.mp3",
      'subtitle' : "Pitbull, Diljit Dosanjh"
    },
     {
      'title' : "Aaj Ki Raat",
      'image' : "https://i.ytimg.com/vi/XY2J5YYNwGY/sddefault.jpg",
      'url' : "https://pagalfree.com/musics/128-Aaj Ki Raat - Stree 2 128 Kbps.mp3",
      'subtitle' : "Amitabh Bhattacharya, Divya Kumar"
    },
   {
      'title' : "ANGAARON",
      'image' : "https://i.ytimg.com/vi/c_ohaI9gZ4U/sddefault.jpg",
      'url' : "https://pagalfree.com/musics/128-Angaaron - Pushpa 2 The Rule 128 Kbps.mp3",
     'subtitle' : "Shreya Ghoshal, Devi Sri Prasad"
   },
    {
      'title' : "AAYI NAI",
      'image' : "https://i.ytimg.com/vi/gcYGwcUmjZo/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLDokTzhL4l-cBTS4mOnrfMqcIIuEw",
      'url' : "https://pagalfree.com/musics/128-Aayi Nai - Stree 2 128 Kbps.mp3",
      'subtitle' : "Amitabh Bhattachaya , Sachin-Jigar"
    },
    {
      'title' : "Maar Udi",
      'image' : "https://i.ytimg.com/vi/3X-KIObXxpA/sddefault.jpg",
      'url' : "https://pagalfree.com/musics/128-Maar Udi - Sarfira 128 Kbps.mp3",
      'subtitle' : "Manoj Muntashir, Sugandh Shekar"
    },
    {
      'title' : "Pushpa Pushpa",
      'image' : "https://pagalfree.com/images/128Pushpa Pushpa - Pushpa 2 The Rule 128 Kbps.jpg",
      'url' : "https://pagalfree.com/musics/128-Pushpa Pushpa - Pushpa 2 The Rule 128 Kbps.mp3",
      'subtitle' : "Mika Singh, Nakash Aziz"
    },
    {
      'title' : "Zaalim",
      'image' : "https://i.ytimg.com/vi/3rWL1mavaKQ/maxresdefault.jpg",
      'url' : "https://pagalfree.com/musics/128-Zaalim - Badshah 128 Kbps.mp3",
      'subtitle' : "Badshah, Payal Dev"
    },
    {
      'title' : "Khaali Botal",
      'image' : "https://i.ytimg.com/vi/Ij483j4RsAQ/sddefault.jpg",
      'url' : "https://pagalfree.com/musics/128-Khaali Botal - Manan Bhardwaj 128 Kbps.mp3",
      'subtitle' : "Manan Bhardwaj, Paramparan Tandon"
    },
    {
      'title' : "Khudaya",
      'image' : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvCg3JYKMHhPXivp0Ti8L5Z-C5yGS4VDOE0Q&s",
      'url' : "https://pagalfree.com/musics/128-Khudaya - Sarfira 128 Kbps.mp3",
      'subtitle' : "Manoj Muntashir, Suhit Abhyanka"
    },
  ];

 // music
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  bool isPlay = false;

  Duration currentDuration = Duration.zero;
  Duration totalDuration = Duration.zero;

  int currentIndex = 0;
  void indexPass(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }
  // video url
  String videoUrl =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
  VideoPlayerController? videoController;
  ChewieController? chewieController;
  bool isVideoInitialized = false;


  HomeProvider() {
    initListen();
    initVideo();
   }


  // Duretion time
  void initListen() {
    audioPlayer.currentPosition.listen((position) {
        currentDuration = position;
      notifyListeners();
    });

    audioPlayer.current.listen((playing) {
      totalDuration = playing?.audio.duration ?? Duration.zero;
      notifyListeners();
    });
  }

  void playOrPause() {
    audioPlayer.playOrPause();
    isPlay = !isPlay;
    notifyListeners();
  }

  void playSong(int index) {
    currentIndex = index;
    audioPlayer.open(
      Audio.network(listOfSong[index]['url']!),
      showNotification: true,
    );
    isPlay = true;
    notifyListeners();
  }

  void nextSong() {
    currentIndex = (currentIndex + 1) % listOfSong.length;
    playSong(currentIndex);
    notifyListeners();
  }

  void previousSong() {
    currentIndex = (currentIndex - 1 + listOfSong.length) % listOfSong.length;
    playSong(currentIndex);
    notifyListeners();
  }

  void seekTo(Duration position) {
    audioPlayer.seek(position);
    notifyListeners();
  }

  void pauseSong() {
    audioPlayer.pause();
    isPlay = false;
    notifyListeners();
  }

  // Video methods
  Future<void> initVideo() async {
    videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    await videoController!.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoController!,
      autoPlay: false,
      looping: true,
    );
    isVideoInitialized = true;
    notifyListeners();
  }

  void playOrPauseVideo() {
    if (videoController!.value.isPlaying)
    {
      videoController!.pause();
    }
    else {
      videoController!.play();
    }
    notifyListeners();
  }

  void disposeVideo() {
    videoController?.dispose();
    chewieController?.dispose();
    isVideoInitialized = false;
    notifyListeners();
  }
}
