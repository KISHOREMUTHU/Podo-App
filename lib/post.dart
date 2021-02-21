class postList{
   final List<Post> posts;
   postList ({this.posts});


   factory postList.fromJson(List <dynamic> parsedJson){
        List<Post> posts = new List <Post>();
        posts = parsedJson.map((i) => Post.fromJson(i)).toList();
    return new postList (posts : posts);

   }
}



class Post {

  int userId;
  int id;
  String title;
  String body;
  Post({this.userId, this.id,this.title,this.body});


  factory Post.fromJson(Map <String, dynamic > json){

      return Post(
        userId : json['userId'],
        id : json['id'],
        title : json['title'],
        body : json['body'],
      );
  }


}