class Link {
  String title;
  String url;

  Link({required this.title, required this.url});

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(title: json['title'], url: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'url': url};
  }
}