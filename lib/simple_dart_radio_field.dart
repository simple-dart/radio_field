import 'dart:html';

import 'package:simple_dart_ui_core/simple_dart_ui_core.dart';

class RadioField<T> extends PanelComponent with ValueChangeEventSource<T?>, MixinDisable implements StateComponent<T?> {
  final List<RadioButtonInputElement> radioButtons = <RadioButtonInputElement>[];
  ObjectStringAdapter<T> adapter = (object) => object.toString();
  String _groupName = '';
  final List<T> _optionList = <T>[];

  RadioField(this._groupName) : super('RadioField') {
    wrap = true;
  }

  String get groupName => _groupName;

  set groupName(String value) {
    _groupName = value;
    radioButtons.forEach((rb) {
      rb.name = value;
    });
  }

  T? get value {
    assert(radioButtons.length == _optionList.length,
        'radioButtons is not actual(${radioButtons.length} != ${_optionList.length})');
    for (var i = 0; i < _optionList.length; i++) {
      if (radioButtons[i].checked == true) {
        return _optionList[i];
      }
    }
    return null;
  }

  set value(T? value) {
    if (value == null) {
      radioButtons.forEach((rb) {
        rb.checked = false;
      });
      return;
    }
    for (var i = 0; i < _optionList.length; i++) {
      if (_optionList[i] == value) {
        radioButtons[i].checked = true;
        return;
      }
    }
  }

  @override
  String get state {
    final val = value;
    if (val == null) {
      return '';
    } else {
      return adapter(val);
    }
  }

  @override
  set state(String newValue) => value = _optionList.firstWhere((element) => adapter(element) == newValue);

  void initOptions(List<T> options) {
    clear();
    _optionList
      ..clear()
      ..addAll(options);
    options.forEach((option) {
      final rowPanel = Panel()..vAlign = Align.center;
      final radioButton = RadioButtonInputElement()..name = groupName;
      final label = LabelElement()
        ..style.paddingLeft = '3px'
        ..style.paddingRight = '10px'
        ..text = adapter(option)
        ..onClick.listen((e) {
          if (disabled) {
            return;
          }
          radioButton.checked = true;
        });
      radioButton.onChange.listen((ev) {
        fireValueChange(value, value);
      });
      radioButtons.add(radioButton);
      rowPanel.element.children.add(radioButton);
      rowPanel.element.children.add(label);
      add(rowPanel);
    });
  }

  void focus() {
    element.focus();
  }

  @override
  List<Element> get disableElements => radioButtons;
}
