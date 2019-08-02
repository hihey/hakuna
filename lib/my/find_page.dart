import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/scheduler.dart';

class FindPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new Page();
  }
}

class Page extends State<FindPage> {
  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return new Scaffold(
      appBar: buildAppBar(context),
      body: new FindBody(),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(title: const Text('资讯'));
  }
}

class FindBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new GridViewState();
}

class GridViewState extends State<FindBody> {
  int page = 1;
  List data = new List();
  var baseUrl = "https://cnodejs.org/api/v1";

  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    this._onRefresh();

    _scrollController = new ScrollController();
    _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
    // 进入页面立即显示刷新动画
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState?.show();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _onLoadMore();
      }
    });
  }

  _fetchData() async {
    var response = await http.get('${this.baseUrl}/topics?mdrender=false&limit=10&page=${this.page}');
    var json = await convert.jsonDecode(response.body);
    return json['data'];
  }

  Future<dynamic> _onRefresh() {
    data.clear();
    this.page = 1;
    return _fetchData().then((data) {
      setState(() => this.data.addAll(data));
    });
  }

  Future<dynamic> _onLoadMore() {
    this.page++;
    return _fetchData().then((data) {
      setState((){
        this.data.addAll(data);
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _loadMoreWidget() {
    return new Padding(
      padding: const EdgeInsets.all(15.0),
      child: new Center(
        child: new CircularProgressIndicator()
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.separated(
          controller: _scrollController,
          itemCount: this.data.length,
          itemBuilder: (context, index) {
            if (index == data.length - 1) {
              return _loadMoreWidget();
            } else {
              var _data = this.data[index];
              return ListTile(
                leading: Image.network(_data["author"]["avatar_url"]),
                title: Text(_data["title"]),
                subtitle: Text(_data["author"]["loginname"] + " created at " + _data["create_at"]),
                trailing: Icon(Icons.chevron_right)
              );
            }
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        )
      )
    );
  }
}
