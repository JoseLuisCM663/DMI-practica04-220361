class VideoPost {
  final String caption; //titulo del video
  final String videoURL; //referencia al video
  final int likes;
  final int views;
  final int comments;

  VideoPost({
    required this.caption,
    required this.videoURL,
    this.likes=0,
    this.views=0,
    this.comments=0,
  });
}
