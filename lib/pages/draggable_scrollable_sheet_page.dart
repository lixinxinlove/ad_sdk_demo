import 'package:flutter/material.dart';

class DraggableScrollableSheetPage extends StatefulWidget {
  const DraggableScrollableSheetPage({super.key});

  @override
  State<DraggableScrollableSheetPage> createState() =>
      _DraggableScrollableSheetPageState();
}

class _DraggableScrollableSheetPageState
    extends State<DraggableScrollableSheetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page"),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Stack(
      children: [
        _sheetWid03(),
      ],
    );
  }

  _sheetWid02() => DraggableScrollableSheet(
      initialChildSize: 0.66,
      builder: (BuildContext context, ScrollController scrollController) =>
          Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0))),
              child: _listWid(null)));

  _sheetWid03() => DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: true,
      builder: (BuildContext context, ScrollController scrollController) =>
          Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0))),
              child: _listWid(scrollController)));

  _listWid(controller) => SingleChildScrollView(
      controller: controller,
      child: Column(children: [
        Container(
            height: 5.0,
            width: 25.0,
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.8),
                borderRadius: const BorderRadius.all(Radius.circular(16.0))),
            margin: const EdgeInsets.symmetric(vertical: 12.0)),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: GridView.builder(
                physics: const ScrollPhysics(),
                primary: false,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 12.0,
                    childAspectRatio: 0.7),
                itemCount: 12,
                itemBuilder: (context, index) => GestureDetector(
                    child: Column(children: <Widget>[
                      PhysicalModel(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          clipBehavior: Clip.antiAlias,
                          child: Image.asset('assets/images/ic_bad_photo_1.png')),
                      const SizedBox(height: 4),
                      const Text('海贼王')
                    ]),
                    onTap: () {}))),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 15,
            itemBuilder: (BuildContext context, index) =>
                ListTile(title: Text('Current Item = ${(index + 1)}')))
      ]));
}
