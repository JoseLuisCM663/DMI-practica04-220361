class VideoPost {
  final String caption; //titulo del video
  final String videoURL; //referencia al video
  final int likes;
  final int views;

  VideoPost({
    required this.caption,
    required this.videoURL,
    this.likes=0,
    this.views=0,
  });
}
