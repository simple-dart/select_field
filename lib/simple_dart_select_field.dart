import 'dart:html';

import 'package:simple_dart_ui_core/simple_dart_ui_core.dart';

class SelectField extends Component
    with ValueChangeEventSource<List<String>>, MixinDisable
    implements StateComponent<List<String>> {
  SelectElement selectElement = SelectElement();

  @override
  Element get element => selectElement;

  List<String> optionList = <String>[];

  SelectField() : super('SelectField') {
    element.onChange.listen((event) {
      fireValueChange(value, value);
    });
  }

  List<String> get value {
    assert(selectElement.options.length == optionList.length,
        'selectElementOptions is not actual(${selectElement.options.length} != ${optionList.length})');
    final ret = <String>[];
    for (var i = 0; i < optionList.length; i++) {
      if (selectElement.options[i].selected) {
        ret.add(optionList[i]);
      }
    }
    return ret;
  }

  set value(List<String> newValue) {
    final oldValue = value;
    for (var i = 0; i < optionList.length; i++) {
      final optionVal = newValue.contains(optionList[i]);
      selectElement.options[i].selected = optionVal;
    }
    fireValueChange(oldValue, newValue);
  }

  @override
  String get state => value.join(',');

  @override
  set state(String newValue) => value = newValue.split(',');

  void focus() {
    selectElement.focus();
  }

  void initOptions(List<String> options) {
    optionList = options;
    for (final option in selectElement.options) {
      option.remove();
    }
    for (final option in options) {
      final optionElement = OptionElement()..text = option;
      selectElement.append(optionElement);
    }
  }

  void selectAll() {
    selectElement.options.forEach((element) {
      element.selected = true;
    });
  }

  void unselectAll() {
    selectElement.options.forEach((element) {
      element.selected = false;
    });
  }

  bool get multiple => selectElement.multiple ?? false;

  set multiple(bool newVal) => selectElement.multiple = newVal;

  int get size => selectElement.size ?? 0;

  set size(int newVal) {
    selectElement.size = newVal;
  }
}
