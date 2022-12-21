import 'dart:html';

import 'package:simple_dart_ui_core/simple_dart_ui_core.dart';

class RadioField extends PanelComponent
    with ValueChangeEventSource<String>, MixinDisable
    implements StateComponent<String> {
  final List<RadioButtonInputElement> radioButtons = [];
  String _groupName = '';

  RadioField() : super('RadioField') {
    wrap = true;
  }

  String get groupName => _groupName;

  set groupName(String value) {
    _groupName = value;
    radioButtons.forEach((rb) {
      rb.name = value;
    });
  }

  String get value => radioButtons.singleWhere((el) => el.checked ?? false).value ?? '';

  set value(String value) => radioButtons.singleWhere((el) => el.value == value).checked = true;

  @override
  String get state => value;

  @override
  set state(String newValue) => value = newValue;

  void addRadioButton(String value, String text) {
    final rowPanel = Panel()..vAlign = Align.center;
    final radioButton = RadioButtonInputElement()
      ..value = value
      ..name = groupName;
    final label = LabelElement()
      ..style.paddingLeft = '3px'
      ..style.paddingRight = '10px'
      ..text = text
      ..onClick.listen((e) {
        if (disabled) {
          return;
        }
        radioButton.checked = true;
      });
    radioButton.onChange.listen((ev) {
      fireValueChange(radioButton.value!, value);
    });
    radioButtons.add(radioButton);
    rowPanel.element.children.add(radioButton);
    rowPanel.element.children.add(label);
    add(rowPanel);
  }

  void focus() {
    element.focus();
  }

  @override
  List<Element> get disableElements => radioButtons;
}
