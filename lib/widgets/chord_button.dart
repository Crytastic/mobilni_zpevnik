import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/models/chord.dart';
import 'package:mobilni_zpevnik/models/preferences.dart';
import 'package:mobilni_zpevnik/providers/preferences_provider.dart';
import 'package:provider/provider.dart';
import 'package:super_tooltip/super_tooltip.dart';

class ChordButton extends StatelessWidget {
  final String chord;
  final _controller = SuperTooltipController();
  final bool down;

  ChordButton({Key? key, required this.chord, required this.down})
      : super(key: key);

  Future<bool> _willPopCallback() async {
    // If the tooltip is open we don't pop the page on a backbutton press
    // but close the ToolTip
    if (_controller.isVisible) {
      await _controller.hideTooltip();
      return false;
    }
    return true;
  }

  final _controller = SuperTooltipController();
  final bool down;

  ChordButton({Key? key, required this.chord, required this.down})
      : super(key: key);

  Future<bool> _willPopCallback() async {
    // If the tooltip is open we don't pop the page on a backbutton press
    // but close the ToolTip
    if (_controller.isVisible) {
      await _controller.hideTooltip();
      return false;
    }
    return true;
  }

  @override
  build(BuildContext context) {
    final bool darkTheme = Theme.of(context).brightness == Brightness.dark;
    final Preferences preferences =
        Provider.of<PreferencesProvider>(context).preferences;
    TooltipDirection tooltipDirection =
        down ? TooltipDirection.down : TooltipDirection.up;

    String getChordName(String chord) {
      String nameString = chord;
      if (!preferences.showMiAsM) {
        nameString = nameString.replaceAll("m", 'mi');
      }
      if (preferences.showBAsH) {
        nameString = nameString.replaceAll("B", 'H');
      }
      return nameString;
    }

    return WillPopScope(
        onWillPop: _willPopCallback,
        child: TapRegion(
            onTapOutside: (event) async {
              await _controller.hideTooltip();
            },
            child: SuperTooltip(
                controller: _controller,
                showBarrier: false,
                constraints: const BoxConstraints(
                    maxWidth: 80, maxHeight: 120, minWidth: 80, minHeight: 120),
                popupDirection: tooltipDirection,
                hideTooltipOnTap: true,
                minimumOutsideMargin: 10,
                content: Image(
                    width: 80,
                    height: 120,
                    image: Chord(name: chord).getImage(darkTheme)),
                child: Container(
                  padding: const EdgeInsets.all(2.0),
                  color: Colors.white12,
                  height: 20,
                  child: Text(
                    getChordName(chord),
                    style: TextStyle(
                        color: (darkTheme ? Colors.white : Colors.black)),
                  ),
                ))));
  }

  void makeTooltip() {
    _controller.showTooltip();
  }

  void hideTooltip() {
    _controller.hideTooltip();
  }
}
