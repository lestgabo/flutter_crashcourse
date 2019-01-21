import 'dart:async';
import 'package:flutter/material.dart';

import 'components/banner_image.dart';
import 'components/default_app_bar.dart';
import 'components/location_tile.dart';
import 'models/location.dart';

import 'location_detail.dart';
import 'styles.dart';

const ListItemHeight = 245.0;

class LocationList extends StatefulWidget {
  @override
  createState() => _LocationListState();
}

// remember, the underscore _ means it will be private only to this file
class _LocationListState extends State<LocationList> {
  List<Location> locations = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold widget is a helper widget that draws a blank screen
    return Scaffold(
      appBar: DefaultAppBar(),
      body: RefreshIndicator(
        // not invoking loadData, referring to it
        onRefresh: loadData,
        child: Column(
          children: [
            renderProgressBar(context),
            Expanded(child: renderListview(context)),
          ],
        ),
      ),
    );
  }

  Future<void> loadData() async {
    // cant do just this, stateful widgets needs to know how/when to rebuild
    // this.locations = locations;
    if (this.mounted) {
      setState(() => this.loading = true);
      Timer(Duration(milliseconds: 3000), () async {
        final locations = await Location.fetchAll();
        setState(() {
          this.locations = locations;
          this.loading = false;
        });
      });
    }
  }

  Widget renderProgressBar(BuildContext context) {
    // ternary operator, 1 condition if else
    return (this.loading
        ? LinearProgressIndicator(
            value: null,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.pink))
        : Container());
  }

  Widget renderListview(BuildContext context) {
    return ListView.builder(
      itemCount: this.locations.length,
      itemBuilder: _listViewItemBuilder,
    );
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    final location = this.locations[index];

    return GestureDetector(
      onTap: () => _navigateToLocationDetail(context, location.id),
      child: (Container(
        height: ListItemHeight,
        child: Stack(children: [
          BannerImage(url: location.url, height: ListItemHeight),
          _tileFooter(location),
        ]),
      )),
    );
  }

  void _navigateToLocationDetail(BuildContext context, int locationID) {
    // print(">>>>> ${this.locations[index].name}");
    // this is a "callback", or a "lexical closure" - function that
    // can access other variables outside of its scope
    Navigator.push(
        context,
        // different routes in Flutter are different screens
        MaterialPageRoute(
          builder: (context) => LocationDetail(locationID),
        ));
  }

  Widget _tileFooter(Location location) {
    final info = LocationTile(location: location, darkTheme: true);
    final overlay = Container(
      padding: EdgeInsets.symmetric(
          vertical: 5.0, horizontal: Styles.horizontalPaddingDefault),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
      child: info,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [overlay],
    );
  }
}
