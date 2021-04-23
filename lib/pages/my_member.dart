import 'package:flutter/material.dart';
import 'package:myappflutter/httpServices/localStore.dart';
import 'package:provider/provider.dart';
import 'package:myappflutter/model/member.dart';
import 'package:myappflutter/httpServices/httpService.dart';
DhflocalStore dhflocalStore =new DhflocalStore();
 

class MyMember extends StatefulWidget{
  @override
  MyMemberNew createState() => new MyMemberNew();
}
tokenGet(context) async{
      dynamic result= await dhflocalStore.getToken();
      HttpService httpService= new HttpService(context);
      print("tokenget11 $result");
      dynamic member;
      if(result!=null){
        member = await httpService.memberGet();
        print("member $member");
      }else{
        Navigator.pushNamed(context, "/login");
      }
      return member;
}
class MyMemberNew extends State<MyMember>{
  @override
  Widget build(BuildContext context) {
  MemberModel member_model = Provider.of<MemberModel>(context);  
    return Scaffold(
      body:FutureBuilder(
        future:tokenGet(context),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.done ){
            print("fff ${snapshot.data}");
            member_model.setMember(snapshot.data);
          } 
          return MemberAvatar();
          print("context $context");
          print("snapshot $snapshot");
        },
      ),
    );
  }
}
class MemberAvatar extends StatefulWidget{
  @override
  _MemberAvatar createState()=> new _MemberAvatar();
}
class _MemberAvatar extends State<MemberAvatar>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    MemberModel member_model = Provider.of<MemberModel>(context);  
    print("name ${member_model.member}");
    return new Container(
      child: new Padding(
        padding: EdgeInsets.only(left: 10.0,top:15.0,right: 10.0,bottom: 15.0),
        child: Row(
          children: [
            new Avatar(),
            new AvatarMemberTools()
          ],
        ),
      ),
      color: Colors.black54,
    ); 
  }
}
class Avatar extends Container{
  Image avatarImg = Image.asset("assets/images/avatar.png",width: 40.0);
  
   void setAvatar(path){
    if(path){

    }else{
      avatarImg = Image.asset("images/avatar.png",width: 40.0);
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("avatar build");
    MemberModel member_model = Provider.of<MemberModel>(context);  
    Map<String,dynamic> member =member_model.member;
    if(member.runtimeType.toString()=="_InternalLinkedHashMap<String, dynamic>"){
      member =new Map<String, dynamic>.from(member);
    }
    print("member build ${member.runtimeType.toString()}");
    String path ;
    if(member.isNotEmpty){
      path=member["avatar"];
    }
    if(path!=null){
      avatarImg = Image.network(path,width: 40.0);
    }else{
      avatarImg = Image.asset("images/avatar.png",width: 40.0);
    }
    return Container(
      child: avatarImg,
      width:40.0,
      height:40.0,
      decoration:BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
      ),
    );
  }
}

class AvatarMemberTools extends StatefulWidget{
  @override
  _AvatarMemberTools createState()=> new _AvatarMemberTools();
}

class _AvatarMemberTools extends State<AvatarMemberTools>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: Column(
        children: [
          new Row(
            children: [
              new Text("登录")
            ],
          ),
          new Row(

          ),
        ],
        crossAxisAlignment:CrossAxisAlignment.start
      ),
      height:50.0
    );
  }
}