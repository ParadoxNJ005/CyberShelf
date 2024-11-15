import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opinionx/models/subjectModel.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/custom_helpr.dart';
import '../models/SpecificSubjectModel.dart';
import '../utils/constants.dart';
import 'SearchPage.dart';

class SubjectDetail extends StatefulWidget {
  final Subject subject;

  const SubjectDetail({super.key, required this.subject});

  @override
  State<SubjectDetail> createState() => _SubjectDetailState();
}

class _SubjectDetailState extends State<SubjectDetail> with SingleTickerProviderStateMixin {
  bool _isSearching = false;
  String _searchText = '';
  late GlobalKey<RefreshIndicatorState> refreshKey;

  @override
  void initState() {
    super.initState();
    refreshKey = GlobalKey<RefreshIndicatorState>();
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Set the number of tabs you need
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Subjects/${widget.subject.subjectCode ?? 'N/A'}',
            style: GoogleFonts.epilogue(
              textStyle: TextStyle(
                color: Constants.BLACK,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          leading: IconButton(
            icon: SvgPicture.asset(
              "assets/svgIcons/hamburger.svg",
              color: Constants.BLACK,
            ),
            onPressed: () {
              // Handle drawer opening
            },
          ),
          actions: [
            IconButton(
              icon: SvgPicture.asset(
                "assets/svgIcons/notification.svg",
                color: Constants.BLACK,
              ),
              onPressed: () {
                // Handle notification action
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.0), // Height of the TabBar
            child: TabBar(
              labelColor: Constants.BLACK,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Constants.BLACK,
              tabs: [
                Tab(text: 'Material'),
                Tab(text: 'Question Paper'),
                Tab(text: 'Links'),
              ],
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: WillPopScope(
            onWillPop: () async {
              if (_isSearching) {
                setState(() {
                  _isSearching = !_isSearching;
                });
                return false;
              } else {
                return true;
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: ListTile(
                      leading: Icon(Icons.search),
                      title: Text("Search Subject..."),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => SearchPage()));
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildTabContent("material"),
                        _buildTabContent("papers"),
                        _buildTabContent("links"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(String type) {
    List<Widget> items = [];
    if (type == "material" && widget.subject.materials != null) {
      items = widget.subject.materials!.map((item) => _subCard(item.title ?? 'No Title', item.contentUrl ?? '', "material", widget.subject.materials!.isEmpty)).toList();
    } else if (type == "papers" && widget.subject.questionPapers != null) {
      items = widget.subject.questionPapers!.map((item) => _subCard(item.title ?? 'No Title', item.url ?? '', "papers", widget.subject.questionPapers!.isEmpty)).toList();
    } else if (type == "links" && widget.subject.importantLinks != null) {
      items = widget.subject.importantLinks!.map((item) => _subCard(item.title ?? 'No Title', item.contentUrl ?? '', "links", widget.subject.importantLinks!.isEmpty)).toList();
    } else {
      return Center(child: Text("No Data Found"));
    }
    return SingleChildScrollView(
      child: Column(
        children: items,
      ),
    );
  }

  Widget _subCard(String title, String link, String type, bool check) {
    if (check) {
      return Container(
        width: double.infinity,
        child: Center(
          child: Text(
            "✏️ NO DATA FOUND!!",
            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () async {
          if (type == "material" || type == "papers") {
            // Handle PDF viewing
          } else {
            try {
              await launch(link);
            } catch (e) {
              Dialogs.showSnackbar(context, "Unable to Load Url: Error($e)");
            }
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Card(
            elevation: 1,
            child: ListTile(
              leading: IconButton(
                icon: SvgPicture.asset(
                  "assets/svgIcons/file_individual.svg",
                ),
                onPressed: () {
                  // Handle icon press
                },
              ),
              title: Text(
                title,
                style: GoogleFonts.epilogue(
                  textStyle: TextStyle(
                    color: Constants.BLACK,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              trailing: _buildPopupMenu(link),
            ),
          ),
        ),
      );
    }
  }

  Widget _buildPopupMenu(String link) {
    return PopupMenuButton<String>(
      onSelected: (value) async {
        switch (value) {
          case 'share':
            Clipboard.setData(ClipboardData(text: link));
            Dialogs.showSnackbar(context, "🔗 Link copied to clipboard!");
            break;
          case 'download':
            Clipboard.setData(ClipboardData(text: link));
            Dialogs.showSnackbar(context, "🔗 Link copied to clipboard!");
            await _showDownloadInstructions(link);
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: 'share',
            child: ListTile(
              leading: Icon(Icons.share, color: Constants.APPCOLOUR),
              title: Text("Share"),
            ),
          ),
          PopupMenuItem(
            value: 'download',
            child: ListTile(
              leading: Icon(Icons.download_sharp, color: Constants.APPCOLOUR),
              title: Text("Download"),
            ),
          ),
        ];
      },
      onCanceled: () {
        log("Popup menu canceled");
      },
    );
  }

  Future<void> _showDownloadInstructions(String url) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Download Instructions'),
          content: Text(
            'To download the PDF, please follow these steps:\n\n'
                '1. Open the Copied link in your browser:\n'
                '$url\n\n'
                '2. Log in with your college account: xxxxxxxxxx@iiita.ac.in\n\n'
                '3. Once logged in, you will be able to download the file.',
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: BorderSide(color: Colors.black, width: 2.0),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () async {
                Navigator.of(context).pop();
                await _openInBrowser(url);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _openInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      log("Error opening URL");
    }
  }
}
