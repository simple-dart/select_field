# SelectField

A selection field from a drop-down list or from a simple list with the ability to select multiple items.

Read in other languages: [English](README.md), [Русский](README.ru.md).

You must initialize initOptions(List<T> options) before using it.

### Properties

- multiple - multiple choice
- size - the number of visible elements in the list
- adapter - adapter for displaying list items (Default: toString)

T - type of list elements

When using elements other than String, you must set the adapter before initializing the options.

### Example

```Dart

class SelectableObject {
  String name = '';

  SelectableObject(this.name);
}

SelectField<SelectableObject>
()..adapter = (
(obj) => obj.name)
..initOptions([
SelectableObject('object1'),
SelectableObject('object2'),
SelectableObject('object3'),
SelectableObject('object4')
])
```