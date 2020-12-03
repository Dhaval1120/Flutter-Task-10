class Detail{

   String classId,className,coachName,classType,classTiming,classColorCode,classImage;
   List signInUserId;
   Detail({this.classId,this.className,this.coachName,this.classType,this.classTiming,this.classColorCode,this.signInUserId,this.classImage});

   factory Detail.fromJson(Map<String , dynamic> json)
   {
     //print(json['signInUserId'].runtimeType);
     return Detail(
       classId : json['classId'],
       className: json['className'],
       coachName: json['coachName'],
       classType: json['classType'],
       classTiming: json['classTiming'],
       classColorCode: json['classColorCode'],
       signInUserId: json['signInUserId'],
       classImage: json['classImage'],
     );
   }
}