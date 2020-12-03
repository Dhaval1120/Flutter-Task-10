class User
{
 String userId, userName,email,profilePic;
 User({this.userId , this.userName ,this.email,this.profilePic});

 static User jsonDe(Map<String , dynamic> json)
 {
   return  User(
       userId : json['userId'],
       userName : json['userName'],
       email : json['email'],
       profilePic : json['profilePic'],
   );
 }
 factory User.fromJson(Map<String , dynamic> json)
 {
   return User(
       userId : json['userId'].toString(),
       userName : json['userName'],
       email : json['email'],
       profilePic : json['profilePic'],);
 }
}