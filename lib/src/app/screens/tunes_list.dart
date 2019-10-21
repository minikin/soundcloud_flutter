import 'package:audio/src/app/widgets/app_bar.dart';
import 'package:audio/src/app/widgets/player_item.dart';
import 'package:audio/src/services/models/models.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';

class TunesList extends StatelessWidget {
  const TunesList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: sharedAppBar(context, 'Music'),
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey[100],
            child: FutureBuilder<BuiltList<Tune>>(
              future: Tune.loadListOfTunes('tunes'),
              builder: (context, AsyncSnapshot<BuiltList<Tune>> snapshot) {
                if (snapshot.hasData) {
                  final tunes = snapshot.data.toList();
                  return ListView.builder(
                    itemCount: tunes.length,
                    itemBuilder: (context, index) {
                      return PlayerItem(tune: tunes[index]);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    'Error ${snapshot.error}',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 24,
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
