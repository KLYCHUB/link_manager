import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:link_manager/link.dart';
import 'package:link_manager/profile.dart';
import 'package:link_manager/storage_service.dart';
import 'package:url_launcher/url_launcher.dart';

import 'env/color/colors.dart';
import 'env/lang/texts.dart';
import 'env/util/constans.dart';

class LinkManager extends StatefulWidget {
  const LinkManager({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LinkManagerState createState() => _LinkManagerState();
}

class _LinkManagerState extends State<LinkManager> {
  List<Link> _links = [];
  final _storageService = StorageService();

  @override
  void initState() {
    super.initState();
    _loadLinks();
  }

  void _loadLinks() async {
    _links = (await _storageService.getLinks()).cast<Link>();
    setState(() {});
  }

  void _addLink(String title, String url) {
    _links.add(Link(title: title, url: url));
    _storageService.saveLinks(_links.cast<Link>());
    setState(() {});
  }

  void _deleteLink(int index) {
    _links.removeAt(index);
    _storageService.saveLinks(_links);
    setState(() {});
  }

  void _editLink(int index, String title, String url) {
    _links[index] = Link(title: title, url: url);
    _storageService.saveLinks(_links);
    setState(() {});
  }

  Future<void> _launchURL(String url) async {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      // ignore: prefer_interpolation_to_compose_strings
      url = 'https://' + url;
    }

    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showAddLinkBottomSheet(BuildContext context) {
    String title = '';
    String url = '';

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: AppEdgeInsets().all16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    AppTexts.addLink,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  height16(),
                  TextField(
                    decoration:
                        const InputDecoration(labelText: AppTexts.title),
                    onChanged: (value) {
                      title = value;
                    },
                  ),
                  height16(),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: AppTexts.url,
                    ),
                    onChanged: (value) {
                      url = value;
                    },
                  ),
                  height16(),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        AppColors.buttonBackgroundColor,
                      ),
                    ),
                    onPressed: () {
                      _addLink(title, url);
                      Navigator.pop(context);
                    },
                    child: const Text(AppTexts.add),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  SizedBox height16() => const SizedBox(height: 16.0);

  void _showLinkOptions(int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text(AppTexts.edit),
              onTap: () {
                Navigator.pop(context);
                _showEditLinkBottomSheet(index);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text(AppTexts.delete),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(AppTexts.confirm),
                      content: const Text(
                        AppTexts.deleteLink,
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text(
                            AppTexts.cancel,
                            style: TextStyle(
                              color: AppColors.linkButtonTextColor,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              AppColors.linkButtonTextColor,
                            ),
                          ),
                          child: const Text(AppTexts.delete),
                          onPressed: () {
                            _deleteLink(index);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditLinkBottomSheet(int index) {
    String title = _links[index].title;
    String url = _links[index].url;

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: AppEdgeInsets().all16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      labelText: AppTexts.title,
                    ),
                    controller: TextEditingController(text: title),
                    onChanged: (value) {
                      title = value;
                    },
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: AppTexts.url,
                    ),
                    controller: TextEditingController(text: url),
                    onChanged: (value) {
                      url = value;
                    },
                  ),
                  height16(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text(
                          AppTexts.cancel,
                          style: TextStyle(
                            color: AppColors.linkButtonTextColor,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            AppColors.linkButtonTextColor,
                          ),
                        ),
                        child: const Text(AppTexts.save),
                        onPressed: () {
                          _editLink(index, title, url);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppTexts.linkManager),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.35,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: _links.length,
              itemBuilder: (context, index) {
                final link = _links[index];
                return Padding(
                  padding: AppEdgeInsets().all16 / 2,
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.linkManagerBackgroundColor,
                        borderRadius: AppBorderRadius().circular4),
                    child: ListTile(
                      title: Text(
                        link.title,
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.backgroundColor,
                                ),
                      ),
                      onTap: () => _launchURL(link.url),
                      onLongPress: () {
                        _showLinkOptions(index);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        iconSize: 25,
        backgroundColor: AppColors.bottomNavBarBackgroundColor,
        selectedItemColor: AppColors.backgroundColor,
        unselectedItemColor: AppColors.backgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                _launchURL(AppTexts.bottomnavbarUrl);
              },
              icon: const FaIcon(FontAwesomeIcons.googlePlay),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                _showAddLinkBottomSheet(context);
              },
              child: const Icon(Icons.add_circle),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const Profile();
                  },
                ));
              },
              icon: const FaIcon(FontAwesomeIcons.circleInfo),
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}
