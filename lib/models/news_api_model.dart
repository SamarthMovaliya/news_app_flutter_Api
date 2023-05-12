class global {
  final dynamic sourceName;
  final dynamic author;
  final dynamic title;
  final dynamic img;
  final dynamic content;
  final dynamic desc;

  global({
    required this.sourceName,
    required this.author,
    required this.title,
    required this.img,
    required this.content,
    required this.desc,
  });

  factory global.fromList({required Map data}) {
    return global(
        sourceName: data['name'],
        author: data['author'],
        title: data['title'],
        img: data['urlToImage'],
        content: data['content'],
        desc: data['description']);
  }
}
