import 'package:audio/src/services/models/models.dart';
import 'package:flutter/material.dart';

class WaveFormItem extends StatefulWidget {
  final Waveform waveform;
  final int trackDuration;
  final int trackPosition;

  WaveFormItem({
    @required this.waveform,
    @required this.trackDuration,
    @required this.trackPosition,
    Key key,
  }) : super(key: key);

  @override
  _WaveFormItemState createState() => _WaveFormItemState();
}

class _WaveFormItemState extends State<WaveFormItem> {
  final _waveformContainerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final data = _gradientPosition(widget.trackPosition);
    print('widget.trackPosition: $data');
    return GestureDetector(
      onTapDown: (details) => _onTapDown(details),
      child: ClipPath(
        clipper: WaveformClipper(widget.waveform),
        child: Container(
          key: _waveformContainerKey,
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [_gradientPosition(widget.trackPosition), 0],
              colors: [
                Colors.orange,
                Colors.grey,
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _gradientPosition(int trackPosition) =>
      trackPosition / widget.trackDuration * 1;

  void _onTapDown(TapDownDetails details) {
    final x = details.globalPosition.dx;
    final y = details.globalPosition.dy;
    print('tap down: $x , $y');
  }
}
