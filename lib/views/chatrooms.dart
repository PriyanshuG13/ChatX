import 'package:chatx/helper/constants.dart';
import 'package:chatx/helper/helperfunctions.dart';
import 'package:chatx/services/database.dart';
import 'package:chatx/views/chat.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Stream chatRooms;
  TextEditingController searchController = TextEditingController();

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                    userName: snapshot.data.documents[index].data['chatRoomId']
                        .toString()
                        .replaceAll("_", "")
                        .replaceFirst(Constants.myName, "", 0),
                    chatRoomId:
                        snapshot.data.documents[index].data["chatRoomId"],
                  );
                })
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfogetChats();
    super.initState();
  }

  getUserInfogetChats() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    DatabaseMethods().getUserChats(Constants.myName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print(
            "we got the data + ${chatRooms.toString()} this is name  ${Constants.myName}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "ChatX",
          style: GoogleFonts.combo(
            color: Colors.white,
            textStyle: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        elevation: 0.0,
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 17, horizontal: 10),
                child: Icon(
                  Icons.edit,
                  size: 25,
                )),
          ),
        ],
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
                padding: EdgeInsets.all(5),
                color: Colors.black,
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            color: Colors.white),
                        child: TextField(
                          controller: searchController,
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 18.0,
                              color: Colors.black),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.search,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            hintText: 'Search',
                            hintStyle: TextStyle(
                                fontFamily: 'WorkSansSemiBold',
                                fontSize: 18.0,
                                color: Colors.grey),
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      height: 2.0,
                      color: Colors.grey[700],
                    ),
                  ],
                )),
            chatRoomsList(),
          ],
        ),
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName, @required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Chat(userName: userName, chatRoomId: chatRoomId)));
      },
      child: Card(
          elevation: 2.0,
          color: Colors.grey[800],
          margin: EdgeInsets.symmetric(vertical: 2.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            height: 80,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              gradient: LinearGradient(
                  colors: <Color>[Colors.redAccent, const Color(0xff2A75BC)],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 1.0),
                  stops: <double>[0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Row(
              children: [
                Container(
                    child: Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.black,
                )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 4),
                      child: Row(
                        children: [
                          Container(
                            width: 240,
                            child: Text(
                              userName,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OverpassRegular',
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            child: Text(
                              "Today",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 200,
                      child: Text(
                        "Message",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'OverpassRegular',
                          color: Colors.black,
                        ),
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
