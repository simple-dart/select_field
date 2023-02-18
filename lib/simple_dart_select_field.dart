import 'dart:html';

import 'package:simple_dart_ui_core/simple_dart_ui_core.dart';

class SelectField<T> extends Component
    with ValueChangeEventSource<List<T>>, MixinDisable
    implements StateComponent<List<T>> {
  SelectElement selectElement = SelectElement();
  ObjectStringAdapter<T> adapter = (object) => object.toString();

  @override
  Element get element => selectElement;

  List<T> optionList = <T>[];

  SelectField() : super('SelectField') {
    element.onChange.listen((event) {
      fireValueChange(value, value);
    });
  }

  List<T> get value {
    assert(selectElement.options.length == optionList.length,
        'selectElementOptions is not actual(${selectElement.options.length} != ${optionList.length})');
    final ret = <T>[];
    for (var i = 0; i < optionList.length; i++) {
      if (selectElement.options[i].selected) {
        ret.add(optionList[i]);
      }
    }
    return ret;
  }

  set value(List<T> newValue) {
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
  set state(String newValue) {
    final valueStringSet = newValue.split(',').toSet();
    value = optionList.where((element) => valueStringSet.contains(adapter(element))).toList();
  }

  void clear() {
    for (final option in selectElement.options) {
      option.remove();
    }
    optionList = <T>[];
  }

  void focus() {
    selectElement.focus();
  }

  void initOptions(List<T> options) {
    clear();
    optionList = options;
    for (final option in options) {
      final optionElement = OptionElement()..text = this.adapter(option);
      selectElement.append(optionElement);
    }
  }

  void initOptionsWithGroups(Map<String, List<T>> groups) {
    clear();
    for (final group in groups.entries) {
      final optGroup = OptGroupElement()..label = group.key;
      for (final option in group.value) {
        final strValue = this.adapter(option);
        final optionElement = OptionElement()
          ..text = strValue
          ..value = strValue;
        optGroup.append(optionElement);
        optionList.add(option);
      }
      selectElement.append(optGroup);
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
