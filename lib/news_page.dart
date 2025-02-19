import 'package:agri_connect/provider/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SocialMediaPage extends StatefulWidget {
  @override
  _SocialMediaPageState createState() => _SocialMediaPageState();
}

class _SocialMediaPageState extends State<SocialMediaPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<NewsProvider>(context, listen: false).getLatestNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "AGRI-NEWS",
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          return newsProvider.posts.isEmpty
              ? const Center(child: CircularProgressIndicator()) // Show loading spinner
              : ListView.builder(
            itemCount: newsProvider.posts.length,
            itemBuilder: (context, index) {
              final post = newsProvider.posts[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: post['profileImagePath'].isNotEmpty
                              ? NetworkImage(post['profileImagePath'])
                              : AssetImage('images/default_avatar.png') as ImageProvider,
                          radius: 25,
                        ),
                        title: Text(post['username'], style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(post['postContent']),
                      ),
                      if (post['postImagePath'].isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Image.network(
                            post['postImagePath'],
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    post['isLiked']
                                        ? Icons.thumb_up_alt
                                        : Icons.thumb_up_alt_outlined,
                                    color: post['isLiked'] ? Colors.blue : Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      newsProvider.posts[index]['isLiked'] =
                                      !newsProvider.posts[index]['isLiked'];
                                    });
                                  },
                                ),
                                Text("Like"),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.comment_outlined),
                                  onPressed: () {},
                                ),
                                Text("Comment"),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.share_outlined),
                                  onPressed: () {},
                                ),
                                Text("Share"),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
