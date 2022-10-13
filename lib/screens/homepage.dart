import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jake_wharton_github/model/jake_wharton_model.dart';
import 'package:jake_wharton_github/utils/constVar.dart';
import 'package:jake_wharton_github/helper/api_helper.dart';
import 'package:http/http.dart' as http;
import 'package:jake_wharton_github/utils/widgets/container_widget_git_tile.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/services.dart' as rootBundle;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 1;
  late int totalPages;
  List<JakeWhartonModel> jakeWhartonList = [];
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  Future<bool> getJakeWhartonGitData({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
    } else {
      if (currentPage >= totalPages) {
        refreshController.loadNoData();
        return false;
      }
    }
    final Uri uri =
        Uri.parse("${APIHelper.baseURL}?page=$currentPage&per_page=15");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result = jakeWhartonModelFromJson(response.body);
      if (isRefresh) {
        jakeWhartonList = result; //.data
      } else {
        jakeWhartonList.addAll(result);
      }

      currentPage++;
      totalPages = 100;
      setState(() {});
      return true;
    } else {
      return false;
    }
  }

  //for offline use
  Future<List<JakeWhartonModel>> ReadJsonData() async{
   final jsonData = await rootBundle.rootBundle.loadString("jsonfile/items.josn");
   final list = json.decode(jsonData) as List<dynamic>;
    return list.map((e) => JakeWhartonModel.fromJson(e)).toList();
  }

  // check internet connection
  internetStatus() async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }else{
        ReadJsonData();
      }
    } on SocketException catch (_) {
      ReadJsonData();
      print('not connected');
    }
  }
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    internetStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appBarTitle),
      ),
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        onRefresh: () async {
          final result = await getJakeWhartonGitData(isRefresh: true);
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result = await getJakeWhartonGitData();
          if (result) {
            refreshController.loadComplete();
          } else {
            refreshController.loadFailed();
          }
        },
        child: ListView.separated(
            itemBuilder: (context, index) {
              final jakeWharton = jakeWhartonList[index];
              return ContainerGitTile(
                title: jakeWharton.name,
                desc: jakeWharton.description,
                language: jakeWharton.language,
                bugs: "${jakeWharton.openIssuesCount}",
                commit: "${jakeWharton.watchersCount}",
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: jakeWhartonList.length),
      ),
    );
  }
}
