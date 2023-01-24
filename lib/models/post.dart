import 'dart:convert';

List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
	Post({
    	required this.id,
    	required this.title,
    	required this.intro,
    	required this.article,
    	required this.image,
    	required this.addDate,
    	required this.editDate,
    	required this.newsLink,
	});

	String id;
	String title;
	String intro;
	String article;
	String image;
	String addDate;
	String editDate;
	String newsLink;

	factory Post.fromJson(Map<String, dynamic> json) => Post(
    	id: json["id"],
    	title: json["title"],
    	intro: json["intro"],
    	article: json["article"],
    	image: json["image"],
    	addDate: json["addDate"],
    	editDate: json["editDate"],
    	newsLink: json["newsLink"],
	);

	Map<String, dynamic> toJson() => {
    	"id": id,
    	"title": title,
    	"intro": intro,
    	"article": article,
    	"image": image,
    	"addDate": addDate,
    	"editDate": editDate,
    	"newsLink": newsLink,
	};
}
