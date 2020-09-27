import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jss_project/constants/constants.dart';
import 'package:jss_project/helperFunctions/sharedFunctions.dart';
import 'package:jss_project/services/database.dart';
import 'package:jss_project/shared/loading.dart';

const kMessageTextFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    hintText: 'Type your message here...',
    hintStyle: TextStyle(color: Colors.white54),
    border: InputBorder.none,
    fillColor: kProfTextColour);

final _firestore = FirebaseFirestore.instance;
User loggedInUser;
String _myName = '';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final messageTextEditingController = TextEditingController();
  DatabaseService databaseService = new DatabaseService();

  String messageText;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _setFunction();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  String _myImage = '';
  // final DatabaseService _databaseService = DatabaseService();

  _setFunction() async {
    await SharedFunctions.getUserNameSharedPreference().then((value) {
      setState(() => _myName = value);
      print(_myName);
    });
    await SharedFunctions.getUserImageSharedPreference().then((imageLink) {
      setState(() => _myImage = imageLink);
    });
  }

  @override
  Widget build(BuildContext context) {
    double _safePaddingTop = MediaQuery.of(context).padding.top;
    double _safePaddingBottom = MediaQuery.of(context).padding.bottom;
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height -
        (_safePaddingBottom + _safePaddingTop);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: kProfPrimaryBackgroundColor,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[],
        title: Text('⚡️Chat'),
        backgroundColor: kProfSecondaryBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              // decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: _width * 0.03,
                  ),
                  Icon(
                    Icons.insert_emoticon,
                    color: kProfTextColour,
                    size: _width * 0.08,
                  ),
                  SizedBox(
                    width: _width * 0.03,
                  ),
                  Container(
                    width: _width / 1.4,
                    decoration: BoxDecoration(
                        color: kProfSecondaryBackgroundColor,
                        borderRadius: BorderRadius.circular(_width * 0.08)),
                    child: TextField(
                      controller: messageTextEditingController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                      style: TextStyle(color: kProfTextColour),
                    ),
                  ),
                  SizedBox(
                    width: _width * 0.03,
                  ),
                  GestureDetector(
                      onTap: () {
                        messageTextEditingController.clear();
                        //message text + sender email
                        Timestamp time = Timestamp.fromMillisecondsSinceEpoch(
                            DateTime.now().millisecondsSinceEpoch);
                        _firestore.collection('messages').add({
                          'text': messageText,
                          'sender': _myName,
                          'time': time.toString(),
                        });
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: _width * 0.03,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        }
        final messages = snapshot.data.docs;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message.data()['text'];
          final messageSender = message.data()['sender'];
          final messageTime = message.data()['time'];
          final currentUser = _myName;
          if (currentUser == messageSender) {}
          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            time: messageTime,
            isOwner: currentUser == messageSender,
          );
          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
      stream: _firestore
          .collection('messages')
          .orderBy('time', descending: true)
          .snapshots(),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final sender;
  final text;
  final bool isOwner;
  final time;

  const MessageBubble(
      {Key key, this.sender, this.text, this.isOwner, this.time})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isOwner ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(color: Colors.white60, fontSize: 10.0),
          ),
          Material(
            borderRadius: BorderRadius.only(
                topRight: isOwner ? Radius.circular(0) : Radius.circular(30),
                topLeft: isOwner ? Radius.circular(30) : Radius.circular(0),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            color: isOwner
                ? kProfSecondaryBackgroundColor
                : kProfSecondaryBackgroundColor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                    color: isOwner ? Colors.white : Colors.white,
                    fontSize: 15.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
