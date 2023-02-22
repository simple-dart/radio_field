import 'package:simple_dart_label/simple_dart_label.dart';
import 'package:simple_dart_ui_core/simple_dart_ui_core.dart';

LabelDisplayPanel<T> labelDisplayPanelAdapter<T>(T value) => LabelDisplayPanel<T>()..value = value;

class LabelDisplayPanel<T> extends DisplayPanel<T> {
  Label label = Label();
  T? _value;

  LabelDisplayPanel() : super('LabelDisplayPanel') {
    add(label);
  }

  @override
  T get value => _value!;

  @override
  set value(T newValue) {
    _value = newValue;
    label.caption = newValue.toString();
  }
}
