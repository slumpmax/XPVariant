# XPVariant

## Easy to use variable supported JSON format for Delphi
* Simple declare and assign any value. (included associated array)
* Convert to JSON text and from JSON text. (JSON and JSONPretty properties)

## Highlights
* uses **XPVariant** and declare variable to **XPVar** type.
* simple assign any value to variable. (Integer, float, double, boolean, string)
* use **XPArray** to assign array values.
* use **XPKey** to assign key/value array members.
* use simple operator to calculate between XPvar and other value types. (+ - * / etc.)
* use **JSON** or **JSONPretty** to get or set JSON format text.
* use **AsInt** or **AsInteger** to forced get or set Integer value.
* use **AsFloat** to forced get or set Double value.
* use **AsBool** or **AsBoolean** to forced get or set Boolean value.
* use **AsStr** or **AsString** to forced get or set String value.

```Delphi
uses
  XPVariant;
var
  k0, k1, k2, k3, k4, k5, k6, k7, k8, k9, k10: XPVar;
begin
  k1 := 56;
  k2 := 78.901 - k1;
  k1[7] := 66;
  k3[5] := 'Delphi' + k2;
  k4['ID'] := nil;
  k5 := XPArray([1, 2, 3, 4, 5.5, 'abc', True, False, nil]);
  k6 := k5;
  k6['7'] := 'A';
  k6['9'] := 'B';
  k7 := k6;
  k7['flag'] := 'end';
  k8.JSON := k6.JSON;
  k8['members'] := XPArray(['continue', 123]);
  k9 := XPArray([
    XPKey('ID', 2),
    XPKey('Data', XPArray([
      XPKey('Name', 'Tom'),
      XPKey('Credit', 678901.23),
      XPKey('Favarite', XPArray(['Banana', 'Durian', 'Lychee']))
    ])),
    'no key'
  ]);
  k10.JSON := Memo2.Text;
  Memo1.Lines.Add(Format('k0: %s', [k0.JSON]));
  Memo1.Lines.Add(Format('k1: %s', [k1.JSON]));
  Memo1.Lines.Add(Format('k2: %s', [k2.JSON]));
  Memo1.Lines.Add(Format('k3: %s', [k3.JSON]));
  Memo1.Lines.Add(Format('k4: %s', [k4.JSON]));
  Memo1.Lines.Add(Format('k5: %s', [k5.JSON]));
  Memo1.Lines.Add(Format('k6: %s', [k6.JSON]));
  Memo1.Lines.Add(Format('k7: %s', [k7.JSON]));
  Memo1.Lines.Add(Format('k8: %s', [k8.JSON]));
  Memo1.Lines.Add(Format('k9: %s', [k9.JSONPretty]));
  Memo1.Lines.Add(Format('k10: %s', [k10.JSONPretty]));
end;
```

* k0: null
* k1: { "0": 56, "7": 66 }
* k2: 22.901
* k3: { "5": "Delphi23" }
* k4: { "ID": null }
* k5: [ 1, 2, 3, 4, 5.5, "abc", true, false, null ]
* k6: [ 1, 2, 3, 4, 5.5, "abc", true, "A", null, "B" ]
* k7: { "0": 1, "1": 2, "2": 3, "3": 4, "4": 5.5, "5": "abc", "6": true, "7": "A", "8": null, "9": "B", "flag": "end" }
* k8: { "0": 1, "1": 2, "2": 3, "3": 4, "4": 5.5, "5": "abc", "6": true, "7": "A", "8": null, "9": "B", "members": [ "continue", 123 ] }
* k9: { "ID": 2, "Data": { "Name": "Tom", "Credit": 678901.23, "Favarite": [ "Banana", "Durian", "Lychee" ] }, "0": "no key" }
* k10: { ... }
