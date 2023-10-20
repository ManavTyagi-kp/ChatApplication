import 'dart:async';

import 'package:firebase_chat_app/UserAuth/loginPage.dart';
import 'package:firebase_chat_app/constants/FirestoreConstants.dart';
import 'package:firebase_chat_app/model/chatUser.dart';
import 'package:firebase_chat_app/pages/chatPage.dart';
import 'package:firebase_chat_app/provider/auth_provider.dart';
import 'package:firebase_chat_app/provider/home_provider.dart';
import 'package:firebase_chat_app/templates/dataContainer.dart';
import 'package:firebase_chat_app/templates/headingTemplates/h1.dart';
import 'package:firebase_chat_app/templates/pageTemplate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double amount = 0;
  int _currentIndex = 0;
  final ScrollController scrollController = ScrollController();

  int _limit = 20;
  final int _limitIncrement = 20;
  String _textSearch = "";
  // bool _isLoading = false;
  bool _search = false;

  late AuthProvider authProvider;
  late String currentUserId;
  late HomeProvider homeProvider;

  StreamController<bool> buttonClearController = StreamController<bool>();
  TextEditingController searchTextEditingController = TextEditingController();

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    buttonClearController.close();
  }

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    homeProvider = context.read<HomeProvider>();
    if (authProvider.getFirebaseUserId()?.isNotEmpty == true) {
      currentUserId = authProvider.getFirebaseUserId()!;
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPageAuth()),
          (route) => false);
    }

    scrollController.addListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double containerHeight = height - (height * 0.38);
    return Scaffold(
      appBar: AppBar(
        leading: _search
            ? TextButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                ),
                onPressed: () {
                  setState(() {
                    _search = false;
                  });
                },
                child: const Icon(
                  Icons.arrow_back_ios_new,
                ),
              )
            : const Icon(null),
        title: _search ? buildSearchBar() : const Text('Rick and Morty'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _search = true;
              });
            },
            icon: _search ? const Icon(null) : const Icon(Icons.search),
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      body: PageTemplate(
        color: const Color.fromARGB(255, 244, 244, 245),
        headChild: Heading1(
          data: 'Chat',
        ),
        dataChild: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
              child: SizedBox(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    myTabBar(0, 'All'),
                    myTabBar(1, 'Office'),
                    myTabBar(2, 'Family'),
                    myTabBar(3, 'Archive'),
                  ],
                ),
              ),
            ),
            DataContainer(
                containerHeight: containerHeight,
                child: StreamBuilder<QuerySnapshot>(
                  stream: homeProvider.getFirestoreData(
                      FirestoreConstants.pathUserCollection,
                      _limit,
                      _textSearch),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      if ((snapshot.data?.docs.length ?? 0) > 0) {
                        return ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                buildItem(context, snapshot.data?.docs[index]),
                            controller: scrollController,
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: snapshot.data!.docs.length);
                      } else {
                        return const Center(
                          child: Text('No user found...'),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
                )),
          ],
        ),
      ),
    );
  }

  Widget myTabBar(int index, String itemName) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Text(
        itemName,
        style: TextStyle(
          fontSize: 20,
          fontWeight:
              _currentIndex == index ? FontWeight.w800 : FontWeight.w600,
          color: _currentIndex == index
              ? const Color.fromARGB(255, 59, 106, 245)
              : Colors.grey,
        ),
      ),
    );
  }

  Widget buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 10,
          ),
          const Icon(
            Icons.person_search,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: TextFormField(
              textInputAction: TextInputAction.search,
              controller: searchTextEditingController,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  buttonClearController.add(true);
                  setState(() {
                    _textSearch = value;
                  });
                } else {
                  buttonClearController.add(false);
                  setState(() {
                    _textSearch = "";
                  });
                }
              },
              decoration: const InputDecoration.collapsed(
                hintText: 'Search here...',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
          StreamBuilder(
              stream: buttonClearController.stream,
              builder: (context, snapshot) {
                return snapshot.data == true
                    ? GestureDetector(
                        onTap: () {
                          searchTextEditingController.clear();
                          buttonClearController.add(false);
                          setState(() {
                            _textSearch = '';
                          });
                        },
                        child: const Icon(
                          Icons.clear_rounded,
                          color: Colors.grey,
                          size: 20,
                        ),
                      )
                    : const SizedBox.shrink();
              })
        ],
      ),
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot? documentSnapshot) {
    final firebaseAuth = FirebaseAuth.instance;
    if (documentSnapshot != null) {
      ChatUser userChat = ChatUser.fromDocument(documentSnapshot);
      if (userChat.id == currentUserId) {
        return const SizedBox.shrink();
      } else {
        return TextButton(
          onPressed: () {
            // if (KeyboardUtils.isKeyboardShowing()) {
            //   KeyboardUtils.closeKeyboard(context);
            // }
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatPage(
                          peerId: userChat.id,
                          peerAvatar: userChat.photoUrl,
                          peerNickname: userChat.displayName,
                          userAvatar: firebaseAuth.currentUser!.photoURL!,
                        )));
          },
          child: ListTile(
            leading: userChat.photoUrl.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      userChat.photoUrl,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                      loadingBuilder: (BuildContext ctx, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                                color: Colors.grey,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null),
                          );
                        }
                      },
                      errorBuilder: (context, object, stackTrace) {
                        return const Icon(Icons.account_circle, size: 50);
                      },
                    ),
                  )
                : const Icon(
                    Icons.account_circle,
                    size: 50,
                  ),
            title: Text(
              userChat.displayName,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }
}
