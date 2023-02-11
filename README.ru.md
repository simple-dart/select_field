# SelectField

Поле выбора из выпадающего списка или из простого списка с возможностью выбора нескольких элементов.

Читать на других языках: [English](README.md), [Русский](README.ru.md).

Необходимо инициализировать initOptions(List<T> options) перед использованием.

### Свойства

- multiple - множественный выбор
- size - количество видимых элементов в списке
- adapter - адаптер для отображения элементов списка (По умолчанию: toString)

T - тип элементов списка

При исползовании элеметнов отличных от String необходимо установить адаптер перед инициализацией опций.

### Пример

```Dart

class SelectableObject {
  String name = '';

  SelectableObject(this.name);
}

SelectField<SelectableObject>()
    ..adapter = ((obj) => obj.name)
    ..initOptions([
        SelectableObject('object1'),
        SelectableObject('object2'),
        SelectableObject('object3'),
        SelectableObject('object4')
    ])
```