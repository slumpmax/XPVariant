unit XPVariant;

interface

uses
  StrUtils, SysUtils, Math;

type
  TXPVarType = (
    XP_UNDEFINED  = 0,
    XP_NULL       = 1,
    XP_INTEGER    = 2,
    XP_BOOLEAN    = 3,
    XP_FLOAT      = 4,
    XP_STRING     = 5,
    XP_ARRAY      = 6,
    XP_KEY        = 7,
    XP_POINTER    = 8
  );
  TXPVarKey = class;
  TXPVarArray = class;
  TXPVarRef = class;
  PXPVar = ^XPVar;
  PXPVarItem = ^XPVarItem;

  TXPVarNull = class(TInterfacedObject, IInterface)
  end;

  TXPVarInteger = class(TInterfacedObject, IInterface)
  public
    Value: Integer;
    constructor Create(AValue: Integer = 0);
  end;

  TXPVarBoolean = class(TInterfacedObject, IInterface)
  public
    Value: Boolean;
    constructor Create(AValue: Boolean = False);
  end;

  TXPVarFloat = class(TInterfacedObject, IInterface)
  public
    Value: Double;
    constructor Create(AValue: Double = 0.0);
  end;

  TXPVarString = class(TInterfacedObject, IInterface)
  public
    Value: string;
    constructor Create(AValue: string = '');
  end;

  TXPVarPointer = class(TInterfacedObject, IInterface)
  public
    Value: Pointer;
    constructor Create(AValue: Pointer = nil);
  end;

  XPVarRef = record
  private
    FVar: TXPVarRef;
    function GetValueOfInt(AKey: Integer): XPVarRef;
    procedure SetValueOfInt(AKey: Integer; AValue: XPVarRef);
    function GetValueOfBool(AKey: Boolean): XPVarRef;
    procedure SetValueOfBool(AKey: Boolean; AValue: XPVarRef);
    function GetValues(AKey: string): XPVarRef;
    procedure SetValues(AKey: string; AValue: XPVarRef);
    function GetValue: PXPVar;
    procedure SetValue(AValue: PXPVar);
    function GetRef: PXPVar;
    procedure SetRef(AValue: PXPVar);
    function GetJSON: string;
    procedure SetJSON(AValue: string);
    function GetJSONPretty: string;
  public
    procedure Clear;

    class operator Implicit(AValue: Boolean): XPVarRef;
    class operator Implicit(AValue: Integer): XPVarRef;
    class operator Implicit(AValue: Double): XPVarRef;
    class operator Implicit(AValue: string): XPVarRef;
    class operator Implicit(AValue: TXPVarKey): XPVarRef;
    class operator Implicit(AValue: TXPVarArray): XPVarRef;
    class operator Implicit(AValue: Pointer): XPVarRef;

    class operator Negative(AValue: XPVarRef): XPVarRef;

    class operator Add(A: XPVarRef; B: Double): XPVarRef;
    class operator Subtract(A: XPVarRef; B: Double): XPVarRef;
    class operator Subtract(A: Double; B: XPVarRef): XPVarRef;

    property JSON: string read GetJSON write SetJSON;
    property JSONPretty: string read GetJSONPretty write SetJSON;
    property Text: string read GetJSON write SetJSON;
    property TextPretty: string read GetJSONPretty write SetJSON;

    property Ref: PXPVar read GetRef write SetRef;
    property Value: PXPVar read GetValue write SetValue;
    property Values[AKey: Integer]: XPVarRef read GetValueOfInt write SetValueOfInt; default;
    property Values[AKey: Boolean]: XPVarRef read GetValueOfBool write SetValueOfBool; default;
    property Values[AKey: string]: XPVarRef read GetValues write SetValues; default;
  end;

  XPVar = record
  private
    FInterface: IInterface;
    function GetType: TXPVarType;
    procedure SetType(AType: TXPVarType);
    function GetValueOfInt(AKey: Integer): XPVarRef;
    procedure SetValueOfInt(AKey: Integer; AValue: XPVarRef);
    function GetValueOfBool(AKey: Boolean): XPVarRef;
    procedure SetValueOfBool(AKey: Boolean; AValue: XPVarRef);
    function GetValues(AKey: string): XPVarRef;
    procedure SetValues(AKey: string; AValue: XPVarRef);
    function GetJSON: string;
    procedure SetJSON(AValue: string);
    function GetJSONPretty: string;
    function GetAsInteger: Integer;
    function GetAsBoolean: Boolean;
    function GetAsFloat: Double;
    function GetAsString: string;
    function GetAsArray: TXPVarArray;
    function GetAsKey: TXPVarKey;
    function GetAsPointer: Pointer;
    procedure SetAsInteger(AValue: Integer);
    procedure SetAsBoolean(AValue: Boolean);
    procedure SetAsFloat(AValue: Double);
    procedure SetAsString(AValue: string);
    procedure SetAsArray(AValue: TXPVarArray);
    function EncodeText(AIndent: Integer = -1): string;
    procedure SetAsKey(AValue: TXPVarKey);
    procedure SetAsPointer(AValue: Pointer);
    function RemoveDummy(): Boolean;
  public
    procedure Clear;
    function EscapeString(AString: string): string;

    class operator Implicit(AValue: Boolean): XPVar;
    class operator Implicit(AValue: Integer): XPVar;
    class operator Implicit(AValue: Double): XPVar;
    class operator Implicit(AValue: string): XPVar;
    class operator Implicit(AValue: TXPVarKey): XPVar;
    class operator Implicit(AValue: TXPVarArray): XPVar;
    class operator Implicit(AValue: Pointer): XPVar;
    class operator Implicit(AValue: XPVarRef): XPVar;
    class operator Implicit(AValue: PXPVar): XPVar;

    class operator Implicit(AValue: XPVar): Boolean;
    class operator Implicit(AValue: XPVar): Integer;
    class operator Implicit(AValue: XPVar): Double;
    class operator Implicit(AValue: XPVar): string;
    class operator Implicit(AValue: XPVar): XPVarRef;

    class operator Negative(AValue: XPVar): XPVar;

    class operator Add(A: XPVar; B: Double): XPVar;
    class operator Add(A: XPVar; B: XPVarRef): XPVarRef;
    class operator Subtract(A: XPVar; B: Double): XPVar;
    class operator Subtract(A: Double; B: XPVar): XPVar;

    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property AsInt: Integer read GetAsInteger write SetAsInteger;

    property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
    property AsBool: Boolean read GetAsBoolean write SetAsBoolean;

    property AsFloat: Double read GetAsFloat write SetAsFloat;

    property AsString: string read GetAsString write SetAsString;
    property AsStr: string read GetAsString write SetAsString;

    property AsPointer: Pointer read GetAsPointer write SetAsPointer;

    property AsArray: TXPVarArray read GetAsArray write SetAsArray;
    property AsKey: TXPVarKey read GetAsKey write SetAsKey;

    property JSON: string read GetJSON write SetJSON;
    property JSONPretty: string read GetJSONPretty write SetJSON;
    property Text: string read GetJSON write SetJSON;
    property TextPretty: string read GetJSONPretty write SetJSON;

    property ValueType: TXPVarType read GetType write SetType;
    property Values[AKey: Integer]: XPVarRef read GetValueOfInt write SetValueOfInt; default;
    property Values[AKey: Boolean]: XPVarRef read GetValueOfBool write SetValueOfBool; default;
    property Values[AKey: string]: XPVarRef read GetValues write SetValues; default;
  end;

  TXPVarRef = class(TInterfacedObject, IInterface)
  private
    FRef: PXPVar;
    FValue: XPVar;
  public
    constructor Create;
  end;

  TXPVarKey = class(TInterfacedObject, IInterface)
  public
    Key: string;
    Value: XPVar;
    constructor Create; overload;
  end;

  XPVarItem = record
    Key: string;
    Value: XPVar;
  end;

  XPVarCodec = record
  private
    FPos, FMaxPos: Integer;
    FText: string;
    function GetChar: Char;
    function GetTrim: Char;
    function GetNumber: XPVar;
    function GetString: string;
    function GetValue: XPVar;
  public
    function Decode(AText: string): XPVar;
  end;
  TXPJson = XPVar;

  TXPVarArray = class(TInterfacedObject, IInterface)
  private
    FRef: PXPVar;
    FIndex: Integer;
    FAssociated: Boolean;
    FItems: array of XPVarItem;
    function GetValues(AKey: string): XPVarRef;
    procedure SetValues(AKey: string; AValue: XPVarRef);
    function GetValueRefs(AKey: string): PXPVar;
    function GetAssociated: Boolean;
    procedure SetAssociated(AValue: Boolean);
    function GetKeys(AIndex: Integer): string;
    function GetItems(AIndex: Integer): XPVarItem;
    function RemoveDummy(): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function Count: Integer;
    function IndexOf(AKey: string; AStart: Integer = -1; AStop: Integer = -1): Integer;
    procedure Assign(AArray: TXPVarArray);
    function Push(AValue: XPVar): Integer;
    property Associated: Boolean read GetAssociated write SetAssociated;
    property Keys[AIndex: Integer]: string read GetKeys;
    property Items[AIndex: Integer]: XPVarItem read GetItems;
    property ValueRefs[AKey: string]: PXPVar read GetValueRefs;
    property Values[AKey: string]: XPVarRef read GetValues write SetValues; default;
  end;

function JsonArrayOf(AValues: array of XPVar): XPVar;
function XPArray(AValues: array of XPVar): XPVar;
function XPKey(AKey: string; AValue: XPVar): XPVar;
function XPNone: XPVar;
function XPNull: XPVar;

implementation

function JsonArrayOf(AValues: array of XPVar): XPVar;
begin
  Result := XPArray(AValues);
end;

function XPArray(AValues: array of XPVar): XPVar;
var
  arr: TXPVarArray;
  n: Integer;
begin
  Result.SetType(XP_ARRAY);
  arr := Result.AsArray;
  for n := 0 to High(AValues) do arr.Push(AValues[n]);
end;

function XPKey(AKey: string; AValue: XPVar): XPVar;
begin
  Result.SetType(XP_KEY);
  with TXPVarKey(Result.FInterface) do
  begin
    Key := AKey;
    Value := AValue;
  end;
end;

function XPNone: XPVar;
begin
  Result.SetType(XP_UNDEFINED);
end;

function XPNull: XPVar;
begin
  Result.SetType(XP_NULL);
end;

{ XPVar }

procedure XPVar.SetAsArray(AValue: TXPVarArray);
begin
  SetType(XP_ARRAY);
  TXPVarArray(FInterface).Assign(AValue);
end;

procedure XPVar.SetAsBoolean(AValue: Boolean);
begin
  FInterface := TXPVarBoolean.Create(AValue);
end;

procedure XPVar.SetAsFloat(AValue: Double);
begin
  FInterface := TXPVarFloat.Create(AValue);
end;

procedure XPVar.SetAsInteger(AValue: Integer);
begin
  FInterface := TXPVarInteger.Create(AValue);
end;

procedure XPVar.SetAsKey(AValue: TXPVarKey);
begin
  SetType(XP_KEY);
  with TXPVarKey(FInterface) do
  begin
    Key := AValue.Key;
    Value := AValue.Value;
  end;
end;

procedure XPVar.SetAsPointer(AValue: Pointer);
begin
  FInterface := TXPVarPointer.Create(AValue);
end;

procedure XPVar.SetAsString(AValue: string);
begin
  FInterface := TXPVarString.Create(AValue);
end;

procedure XPVar.SetJSON(AValue: string);
var
  codec: XPVarCodec;
begin
  Clear;
  Self := codec.Decode(AValue);
end;

procedure XPVar.SetType(AType: TXPVarType);
begin
  case AType of
    XP_NULL     : FInterface := TXPVarNull.Create;
    XP_INTEGER  : FInterface := TXPVarInteger.Create;
    XP_BOOLEAN  : FInterface := TXPVarBoolean.Create;
    XP_FLOAT    : FInterface := TXPVarFloat.Create;
    XP_STRING   : FInterface := TXPVarString.Create;
    XP_ARRAY    : FInterface := TXPVarArray.Create;
    XP_KEY      : FInterface := TXPVarKey.Create;
    XP_POINTER  : FInterface := TXPVarPointer.Create;
  else
    FInterface := nil;
  end;
end;

procedure XPVar.SetValueOfBool(AKey: Boolean; AValue: XPVarRef);
begin
  SetValues(IfThen(AKey, '1', '0'), AValue);
end;

procedure XPVar.SetValueOfInt(AKey: Integer; AValue: XPVarRef);
begin
  SetValues(IntToStr(AKey), AValue);
end;

procedure XPVar.SetValues(AKey: string; AValue: XPVarRef);
begin
  AsArray[AKey] := AValue
end;

class operator XPVar.Subtract(A: Double; B: XPVar): XPVar;
begin
  case B.ValueType of
    XP_INTEGER: Result := A - B.AsFloat;
    XP_BOOLEAN: Result := A - IfThen(B.AsBoolean, 1.0, 0.0);
    XP_FLOAT: Result := A - B.AsFloat;
    XP_STRING: Result := FloatToStr(A) + B.AsString;
    XP_POINTER: Result := A - Integer(B.AsPointer);
    XP_ARRAY:
    begin
      Result := A;
      Result.AsArray.Push(B);
    end;
  else
    Result := -B;
  end;
end;

class operator XPVar.Subtract(A: XPVar; B: Double): XPVar;
begin
  case A.ValueType of
    XP_INTEGER: Result := A.AsFloat - B;
    XP_BOOLEAN: Result := IfThen(A.AsBoolean, 1, 0) - B;
    XP_FLOAT: Result := A.AsFloat - B;
    XP_STRING: Result := A.AsString + FloatToStr(B);
    XP_POINTER: Result := Integer(A.AsPointer) - B;
    XP_ARRAY:
    begin
      Result := A;
      Result.AsArray.Push(B);
    end;
  else
    Result := -B;
  end;
end;

class operator XPVar.Add(A: XPVar; B: Double): XPVar;
begin
  case A.ValueType of
    XP_INTEGER: Result.AsFloat := A.AsInteger + B;
    XP_BOOLEAN: Result.AsFloat := A.AsInteger + B;
    XP_FLOAT: Result.AsFloat := A.AsFloat + B;
    XP_STRING: Result.AsString := A.AsString + FloatToStr(B);
    XP_POINTER: Result := Integer(A.AsPointer) + B;
    XP_ARRAY:
    begin
      Result := A.AsArray;
      Result.AsArray.Push(B);
    end
  else
    Result.AsFloat := B;
  end;
end;

class operator XPVar.Add(A: XPVar; B: XPVarRef): XPVarRef;
begin
  Result.Clear;
  Result.FVar.FRef := @Result.FVar.FValue;
  Result.FVar.FValue := A + B.FVar.FValue;
end;

procedure XPVar.Clear;
begin
  SetType(XP_UNDEFINED);
end;

function XPVar.EncodeText(AIndent: Integer): string;
var
  arr: TXPVarArray;
  vk: TXPVarKey;
  n: Integer;
  spc, spc2, ret: string;
begin
  RemoveDummy;
  Result := '';
  if AIndent >= 0 then
  begin
    spc := DupeString(' ', AIndent);
    spc2 := spc + '  ';
    ret := #13#10;
  end
  else
  begin
    spc := '';
    spc2 := '';
    ret := ' ';
  end;
  case ValueType of
    XP_UNDEFINED, XP_NULL: Result := 'null';
    XP_BOOLEAN: Result := IfThen(AsBoolean, 'true', 'false');
    XP_FLOAT: Result := FloatToStr(AsFloat);
    XP_INTEGER: Result := IntToStr(AsInteger);
    XP_STRING: Result := '"' + EscapeString(AsString) + '"';
    XP_POINTER: Result := IntToStr(Integer(AsPointer));
    XP_KEY:
    begin
      vk := TXPVarKey(FInterface);
      Result := vk.Key + ': ' + vk.Value.EncodeText(AIndent);
    end;
    XP_ARRAY:
    begin
      arr := AsArray;
      for n := 0 to arr.Count - 1 do
      begin
        if Result <> '' then Result := Result + ',' + ret;
        Result := Result + spc2;
        if arr.Associated then Result := Result + '"' + EscapeString(arr.Items[n].Key) + '": ';
        Result := Result + arr.Items[n].Value.EncodeText(IfThen(AIndent >= 0, AIndent + 2, -1));
      end;
      if arr.Associated then
        Result := '{' + ret + Result + ret + spc + '}'
      else Result := '[' + ret + Result + ret + spc + ']';
    end;
  end;
end;

function XPVar.EscapeString(AString: string): string;
var
  n, nmax: Integer;
  c, d: Char;
begin
  Result := '';
  nmax := Length(AString);
  n := 1;
  while n <= nmax do
  begin
    c := ASTring[n];
    if n < nmax then
      d := AString[n + 1]
    else d := #0;
    case c of
      #9: Result := Result + '\t';
      #10: Result := Result + '\n';
      #13:
      begin
        if d = #10 then
        begin
          Result := Result + '\n';
          Inc(n);
        end
        else Result := Result + '\r';
      end;
      '"': Result := Result + '\"';
      '\': Result := Result + '\\';
    else
      Result := Result + c;
    end;
    Inc(n);
  end;
end;

function XPVar.GetAsArray: TXPVarArray;
var
  ar: TXPVarArray;
begin
  case ValueType of
    XP_ARRAY:
    begin
      ar := TXPVarArray(FInterface);
      if ar.FRef <> @Self then
      begin
        Result := TXPVarArray.Create;
        Result.Assign(ar);
        Result.FRef := @Self;
        FInterface := Result;
      end
      else Result := ar;
    end;
  else
    Result := TXPVarArray.Create;
    case ValueType of
      XP_INTEGER: TXPVarArray(Result).Push(AsInteger);
      XP_BOOLEAN: TXPVarArray(Result).Push(AsBoolean);
      XP_FLOAT: TXPVarArray(Result).Push(AsFloat);
      XP_STRING: TXPVarArray(Result).Push(AsString);
      XP_KEY: TXPVarArray(Result).Push(AsKey);
      XP_POINTER: TXPVarArray(Result).Push(AsPointer);
    end;
    FInterface := Result;
  end;
end;

function XPVar.GetAsBoolean: Boolean;
var
  s: string;
begin
  case ValueType of
    XP_INTEGER: Result := TXPVarInteger(FInterface).Value <> 0;
    XP_BOOLEAN: Result := TXPVarBoolean(FInterface).Value;
    XP_FLOAT: Result := TXPVarFloat(FInterface).Value <> 0.0;
    XP_STRING:
    begin
      s := UpperCase(TXPVarString(FInterface).Value);
      Result := (s = 'TRUE') or (StrToFloatDef(s, 0.0) <> 0.0);
    end;
    XP_KEY: Result := TXPVarKey(FInterface).Value.AsBoolean;
    XP_POINTER: Result := TXPVarPointer(FInterface).Value <> nil;
    XP_ARRAY: Result := False;
  else
    Result := False;
  end;
end;

function XPVar.GetAsFloat: Double;
begin
  case ValueType of
    XP_INTEGER: Result := TXPVarInteger(FInterface).Value;
    XP_BOOLEAN: Result := IfThen(TXPVarBoolean(FInterface).Value, 1.0, 0.0);
    XP_FLOAT: Result := TXPVarFloat(FInterface).Value;
    XP_STRING: Result := StrToFloatDef(TXPVarString(FInterface).Value, 0.0);
    XP_KEY: Result := TXPVarKey(FInterface).Value.AsFloat;
    XP_POINTER: Result := Integer(TXPVarPointer(FInterface).Value);
    XP_ARRAY: Result := 0.0;
  else
    Result := 0.0;
  end;
end;

function XPVar.GetAsInteger: Integer;
begin
  case ValueType of
    XP_INTEGER: Result := TXPVarInteger(FInterface).Value;
    XP_BOOLEAN: Result := IfThen(TXPVarBoolean(FInterface).Value, 1, 0);
    XP_FLOAT: Result := Round(TXPVarFloat(FInterface).Value);
    XP_STRING: Result := StrToIntDef(TXPVarString(FInterface).Value, 0);
    XP_KEY: Result := TXPVarKey(FInterface).Value.AsInteger;
    XP_POINTER: Result := Integer(TXPVarPointer(FInterface).Value);
    XP_ARRAY: Result := 0;
  else
    Result := 0;
  end;
end;

function XPVar.GetAsKey: TXPVarKey;
begin
  if ValueType = XP_KEY then
    Result := TXPVarKey(FInterface)
  else
  begin
    Result := TXPVarKey.Create;
    case ValueType of
      XP_INTEGER: TXPVarKey(Result).Value.AsInteger := AsInteger;
      XP_BOOLEAN: TXPVarKey(Result).Value.AsBoolean := AsBoolean;
      XP_FLOAT: TXPVarKey(Result).Value.AsFloat := AsFloat;
      XP_STRING: TXPVarKey(Result).Value.AsString := AsString;
      XP_POINTER: TXPVarKey(Result).Value.AsInteger := AsInteger;
      XP_ARRAY: TXPVarKey(Result).Value.AsArray := AsArray;
    end;
    FInterface := Result;
  end;
end;

function XPVar.GetAsPointer: Pointer;
begin
  case ValueType of
    XP_UNDEFINED, XP_NULL: Result := nil;
    XP_INTEGER: Result := @TXPVarInteger(FInterface).Value;
    XP_BOOLEAN: Result := @TXPVarBoolean(FInterface).Value;
    XP_FLOAT: Result := @TXPVarFloat(FInterface).Value;
    XP_STRING: Result := @TXPVarString(FInterface).Value;
    XP_POINTER: Result := TXPVarPointer(FInterface).Value;
    XP_KEY: Result := @TXPVarKey(FInterface).Value;
  else
    Result := FInterface;
  end;
end;

function XPVar.GetAsString: string;
begin
  case ValueType of
    XP_INTEGER: Result := IntToStr(TXPVarInteger(FInterface).Value);
    XP_BOOLEAN: Result := IfThen(TXPVarBoolean(FInterface).Value, '1', '0');
    XP_FLOAT: Result := FloatToStr(TXPVarFloat(FInterface).Value);
    XP_STRING: Result := TXPVarString(FInterface).Value;
    XP_KEY: Result := TXPVarKey(FInterface).Value.AsString;
    XP_POINTER: Result := IntToStr(Integer(TXPVarPointer(FInterface).Value));
    XP_ARRAY: Result := 'Array';
  else
    Result := '';
  end;
end;

function XPVar.GetJSON: string;
begin
  Result := EncodeText;
end;

function XPVar.GetJSONPretty: string;
begin
  Result := EncodeText(0);
end;

function XPVar.GetType: TXPVarType;
begin
  if FInterface is TXPVarNull then
    Result := XP_NULL
  else if FInterface is TXPVarInteger then
    Result := XP_INTEGER
  else if FInterface is TXPVarBoolean then
    Result := XP_BOOLEAN
  else if FInterface is TXPVarFloat then
    Result := XP_FLOAT
  else if FInterface is TXPVarArray then
    Result := XP_ARRAY
  else if FInterface is TXPVarKey then
    Result := XP_KEY
  else if FInterface is TXPVarString then
    Result := XP_STRING
  else if FInterface is TXPVarPointer then
    Result := XP_POINTER
  else Result := XP_UNDEFINED;
end;

function XPVar.GetValueOfBool(AKey: Boolean): XPVarRef;
begin
  Result := GetValues(IfThen(AKey, '1', '0'));
end;

function XPVar.GetValueOfInt(AKey: Integer): XPVarRef;
begin
  Result := GetValues(IntToStr(AKey));
end;

function XPVar.GetValues(AKey: string): XPVarRef;
begin
  Result := AsArray[AKey];
end;

class operator XPVar.Implicit(AValue: Pointer): XPVar;
begin
  if (AValue <> nil) then
    Result.AsPointer := AValue
  else Result.SetType(XP_NULL);
end;

class operator XPVar.Implicit(AValue: Double): XPVar;
begin
  Result.AsFloat := AValue;
end;

class operator XPVar.Implicit(AValue: Integer): XPVar;
begin
  Result.AsInteger := AValue;
end;

class operator XPVar.Implicit(AValue: Boolean): XPVar;
begin
  Result.AsBoolean := AValue;
end;

class operator XPVar.Implicit(AValue: string): XPVar;
begin
  Result.AsString := AValue;
end;

class operator XPVar.Implicit(AValue: XPVar): string;
begin
  Result := AValue.AsString;
end;

class operator XPVar.Implicit(AValue: XPVarRef): XPVar;
var
  ar: TXPVarArray;
begin
  case AValue.FVar.FRef.ValueType of
    XP_ARRAY:
    begin
      ar := TXPVarArray.Create;
      ar.Assign(TXPVarArray(AValue.FVar.FRef.FInterface));
      ar.FRef := @Result;
      Result.FInterface := ar;
    end
  else
    Result := AValue.FVar.FRef^;
  end;
end;

class operator XPVar.Implicit(AValue: TXPVarKey): XPVar;
begin
  Result.AsKey := AValue;
end;

class operator XPVar.Negative(AValue: XPVar): XPVar;
begin
  case AValue.ValueType of
    XP_INTEGER: Result := -AValue.AsInteger;
    XP_BOOLEAN: Result := not AValue.AsBoolean;
    XP_FLOAT: Result := -AValue.AsFloat;
    XP_STRING: Result := ReverseString(AValue.AsString);
    XP_KEY:
    begin
      Result := AValue;
      TXPVarKey(Result.FInterface).Value := -Result.AsKey.Value;
    end
  else
    Result := AValue;
  end;
end;

function XPVar.RemoveDummy: Boolean;
begin
  case ValueType of
    XP_ARRAY: Result := AsArray.RemoveDummy;
    XP_UNDEFINED: Result := True;
  else
    Result := False;
  end;
end;

class operator XPVar.Implicit(AValue: TXPVarArray): XPVar;
begin
  Result.Clear;
  Result.AsArray.Assign(TXPVarArray(AValue));
end;

class operator XPVar.Implicit(AValue: XPVar): Double;
begin
  Result := AValue.AsFloat;
end;

class operator XPVar.Implicit(AValue: XPVar): Integer;
begin
  Result := AValue.AsInteger;
end;

class operator XPVar.Implicit(AValue: XPVar): Boolean;
begin
  Result := AValue.AsBoolean;
end;

class operator XPVar.Implicit(AValue: XPVar): XPVarRef;
begin
  Result.Clear;
  Result.FVar.FRef := @Result.FVar.FValue;
  Result.FVar.FValue := AValue;
end;

class operator XPVar.Implicit(AValue: PXPVar): XPVar;
begin
  Result := AValue^;
end;

{ TXPVarArray }

procedure TXPVarArray.Assign(AArray: TXPVarArray);
var
  n: Integer;
begin
  SetLength(FItems, Length(AArray.FItems));
  for n := 0 to Length(AArray.FItems) - 1 do
  begin
    FItems[n] := AArray.FItems[n];
  end;
  FIndex := AArray.FIndex;
  FAssociated := AArray.FAssociated;
end;

procedure TXPVarArray.Clear;
var
  n: Integer;
begin
  n := Length(FItems);
  while n > 0 do
  begin
    Dec(n);
    FItems[n].Value.SetType(XP_UNDEFINED);
  end;
  FItems := nil;
end;

function TXPVarArray.Count: Integer;
begin
  Result := Length(FItems);
end;

constructor TXPVarArray.Create;
begin
  FRef := nil;
  FItems := nil;
  FIndex := 0;
  FAssociated := False;
end;

destructor TXPVarArray.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TXPVarArray.GetAssociated: Boolean;
begin
  Result := FAssociated;
end;

function TXPVarArray.GetItems(AIndex: Integer): XPVarItem;
begin
  Result := FItems[AIndex];
end;

function TXPVarArray.GetKeys(AIndex: Integer): string;
begin
  Result := FItems[AIndex].Key;
end;

function TXPVarArray.GetValueRefs(AKey: string): PXPVar;
var
  v: XPVarItem;
  n: Integer;
begin
  n := IndexOf(AKey);
  if n < 0 then
  begin
    n := Length(FItems);
    v.Key := AKey;
    v.Value.Clear;
    Insert(v, FItems, n);
    if IntToStr(FIndex) = AKey then
      Inc(FIndex)
    else FAssociated := True;
  end;
  Result := @FItems[n].Value;
end;

function TXPVarArray.GetValues(AKey: string): XPVarRef;
begin
  Result.Clear;
  Result.FVar.FRef := ValueRefs[AKey];
  Result.FVar.FValue := Result.FVar.FRef^;
end;

function TXPVarArray.IndexOf(AKey: string; AStart, AStop: Integer): Integer;
var
  n: integer;
begin
  Result := -1;
  n := Length(FItems);
  while (Result < 0) and (n > 0) do
  begin
    Dec(n);
    if FItems[n].Key = AKey then Result := n;
  end;
end;

function TXPVarArray.Push(AValue: XPVar): Integer;
var
  key: TXPVarKey;
  v: XPVarRef;
begin
  if AValue.ValueType = XP_KEY then
  begin
    key := AValue.AsKey;
    v.Value := @AValue;
    SetValues(key.Key, v);
    Result := IndexOf(key.Key);
  end
  else
  begin
    Result := FIndex;
    v.Value := @AValue;
    SetValues(IntToStr(Result), v);
  end;
end;

function TXPVarArray.RemoveDummy: Boolean;
var
//  v: PXPVar;
  n: Integer;
begin
  Result := False;
  n := Length(FItems);
  while n > 0 do
  begin
    Dec(n);
    if FItems[n].Value.RemoveDummy then
    begin
      if n < Length(FItems) - 1 then FAssociated := True;
      Delete(FItems, n, 1);
      Result := True;
    end;
  end;
  Result := Result and (Length(FItems) = 0);
end;

procedure TXPVarArray.SetAssociated(AValue: Boolean);
begin
  FAssociated := AValue;
end;

procedure TXPVarArray.SetValues(AKey: string; AValue: XPVarRef);
var
  key: TXPVarKey;
  ar: TXPVarArray;
  v: PXPVar;
begin
  case AValue.FVar.FRef.ValueType of
    XP_KEY:
    begin
      key := TXPVarKey(AValue.FVar.FRef.FInterface);
      ValueRefs[key.Key]^ := key.Value;
    end;
    XP_ARRAY:
    begin
      v := ValueRefs[AKey];
      ar := TXPVarArray.Create;
      ar.Assign(TXPVarArray(AValue.FVar.FRef.FInterface));
      ar.FRef := v;
      v.FInterface := ar;
    end
  else
    ValueRefs[AKey]^ := AValue.FVar.FRef^;
  end;
end;

{ TXPVarString }

constructor TXPVarString.Create(AValue: string);
begin
  Value := AValue;
end;

{ TXPVarInteger }

constructor TXPVarInteger.Create(AValue: Integer);
begin
  Value := AValue;
end;

{ TXPVarBoolean }

constructor TXPVarBoolean.Create(AValue: Boolean);
begin
  Value := AValue;
end;

{ TXPVarFloat }

constructor TXPVarFloat.Create(AValue: Double);
begin
  Value := AValue;
end;

{ XPVarCodec }

function XPVarCodec.Decode(AText: string): XPVar;
begin
  FText := AText;
  FPos := 1;
  FMaxPos := Length(FText);
  Result := GetValue;
end;

function XPVarCodec.GetChar: Char;
begin
  if FPos <= FMaxPos then
    Result := FText[FPos]
  else Result := #26;
end;

function XPVarCodec.GetNumber: XPVar;
var
  apos: Integer;
  s: string;
  dm: Boolean;
  c: Char;
begin
  apos := FPos;
  c := GetChar;
  while (c >= '0') and (c <= '9') do
  begin
    Inc(FPos);
    c := GetChar;
  end;
  dm := c = '.';
  if dm then
  begin
    Inc(FPos);
    c := GetChar;
    while (c >= '0') and (c <= '9') do
    begin
      Inc(FPos);
      c := GetChar;
    end;
  end;
  s := Copy(FText, apos, FPos - apos);
  if dm then
    Result := StrToFloatDef(s, 0.0)
  else Result := StrToIntDef(s, 0);
end;

function XPVarCodec.GetString: string;
var
  c: Char;
begin
  Result := '';
  if GetTrim <> '"' then raise Exception.Create('Invalid JSON string.');
  Inc(FPos);
  c := GetTrim;
  while (c <> '"') and (c <> #26) do
  begin
    case c of
      '\':
      begin
        Inc(FPos);
        c := GetChar;
        case c of
          '\': Result := Result + '\';
          '/': Result := Result + '/';
          '"': Result := Result + '"';
          'b': Result := Result + #8;
          'f': Result := Result + #12;
          'n': Result := Result + #10;
          'r': Result := Result + #13;
          't': Result := Result + #9;
          'u':
          begin
            Result := Result + Copy(FText, FPos + 1, 4);
            Inc(FPos, 5);
          end
        else
          Result := Result + c;
        end;
      end;
    else
      Result := Result + c;
    end;
    Inc(FPos);
    c := GetChar;
  end;
  if GetChar <> '"' then raise Exception.Create('Invalid JSON string.');
  Inc(FPos);
end;

function XPVarCodec.GetTrim: Char;
begin
  Result := GetChar;
  while ((Result = ' ') or (Result = #13) or (Result = #10) or (Result = #9)) do
  begin
    Inc(FPos);
    Result := GetChar;
  end;
end;

function XPVarCodec.GetValue: XPVar;
var
  arr: TXPVarArray;
  v: XPVar;
  rv: XPVarRef;
  s: string;
  c: Char;
begin
  Result.Clear;
  c := UpCase(GetTrim);
  case c of
    'N':
      if UpperCase(Copy(FText, FPos, 4)) = 'NULL' then
      begin
        Result := XPNull;
        Inc(FPos, 4);
      end
      else raise Exception.Create('Invalid JSON value.');
    'T':
      if UpperCase(Copy(FText, FPos, 4)) = 'TRUE' then
      begin
        Result := True;
        Inc(FPos, 4);
      end
      else raise Exception.Create('Invalid JSON value.');
    'F':
      if UpperCase(Copy(FText, FPos, 5)) = 'FALSE' then
      begin
        Result := False;
        Inc(FPos, 5);
      end
      else raise Exception.Create('Invalid JSON value.');
    '[':
    begin
      Inc(FPos);
      arr := Result.AsArray;
      v := GetValue;
      while v.ValueType <> XP_UNDEFINED do
      begin
        arr.Push(v);
        c := GetTrim;
        if c = ',' then
        begin
          Inc(FPos);
          v := GetValue;
        end
        else v.Clear;
      end;
      c := GetTrim;
      if c = ']' then
        Inc(FPos)
      else raise Exception.Create('Invalid JSON array.');
    end;
    '{':
    begin
      Inc(FPos);
      arr := Result.AsArray;
      c := GetTrim;
      while (c <> '}') and (c <> #26) do
      begin
        s := GetString;
        if GetTrim <> ':' then raise Exception.Create('Invalid JSON object.');
        Inc(FPos);
        v := GetValue;
        rv.Ref := @v;
        arr[s] := rv;
        c := GetTrim;
        if c = ',' then
        begin
          Inc(FPos);
          c := GetTrim;
        end
        else c := '}';
      end;
      if GetTrim <> '}' then raise Exception.Create('Invalid JSON object');
      Inc(FPos);
    end;
    '0'..'9','.': Result := GetNumber;
    '+':
    begin
      Inc(FPos);
      Result := GetNumber;
    end;
    '-':
    begin
      Inc(FPos);
      Result := -GetNumber;
    end;
    '"': Result := GetString;
  else
    raise Exception.Create('Invalid JSON data.');
  end;
end;

{ TXPVarKey }

constructor TXPVarKey.Create;
begin
  Key := '';
  Value.SetType(XP_UNDEFINED);
end;

{ TXPVarPointer }

constructor TXPVarPointer.Create(AValue: Pointer);
begin
  Value := AValue;
end;

{ TXPVarRef }

constructor TXPVarRef.Create;
begin
  FValue.Clear;
  FRef := @FValue;
end;

{ XPVarRef }

class operator XPVarRef.Add(A: XPVarRef; B: Double): XPVarRef;
begin
  Result.Clear;
  Result.FVar.FRef := @Result.FVar.FValue;
  Result.FVar.FValue := A.FVar.FRef^ + B;
end;

procedure XPVarRef.Clear;
begin
  FVar := TXPVarRef.Create;
end;

function XPVarRef.GetJSON: string;
begin
  Result := FVar.FRef.GetJSON;
end;

function XPVarRef.GetJSONPretty: string;
begin
  Result := FVar.FRef.GetJSONPretty;
end;

function XPVarRef.GetRef: PXPVar;
begin
  Result := FVar.FRef;
end;

function XPVarRef.GetValue: PXPVar;
begin
  Result := FVar.FRef;
end;

function XPVarRef.GetValueOfBool(AKey: Boolean): XPVarRef;
begin
  Result := GetValues(IfThen(AKey, '1', '0'));
end;

function XPVarRef.GetValueOfInt(AKey: Integer): XPVarRef;
begin
  Result := GetValues(IntToStr(AKey));
end;

function XPVarRef.GetValues(AKey: string): XPVarRef;
begin
  Result := FVar.FRef.AsArray[AKey];
end;

class operator XPVarRef.Implicit(AValue: Double): XPVarRef;
begin
  Result.Clear;
  Result.FVar.FRef := @Result.FVar.FValue;
  Result.FVar.FValue := AValue;
end;

class operator XPVarRef.Implicit(AValue: Integer): XPVarRef;
begin
  Result.Clear;
  Result.FVar.FRef := @Result.FVar.FValue;
  Result.FVar.FValue := AValue;
end;

class operator XPVarRef.Implicit(AValue: Boolean): XPVarRef;
begin
  Result.Clear;
  Result.FVar.FRef := @Result.FVar.FValue;
  Result.FVar.FValue := AValue;
end;

class operator XPVarRef.Implicit(AValue: string): XPVarRef;
begin
  Result.Clear;
  Result.FVar.FRef := @Result.FVar.FValue;
  Result.FVar.FValue := AValue;
end;

class operator XPVarRef.Implicit(AValue: Pointer): XPVarRef;
begin
  Result.Clear;
  Result.FVar.FRef := @Result.FVar.FValue;
  Result.FVar.FValue := AValue;
end;

class operator XPVarRef.Negative(AValue: XPVarRef): XPVarRef;
begin
  Result.Clear;
  Result.FVar.FRef := @Result.FVar.FValue;
  Result.FVar.FValue := -AValue.FVar.FRef^;
end;

class operator XPVarRef.Implicit(AValue: TXPVarArray): XPVarRef;
begin
  Result.Clear;
  Result.FVar.FRef := @Result.FVar.FValue;
  Result.FVar.FValue := AValue;
end;

class operator XPVarRef.Implicit(AValue: TXPVarKey): XPVarRef;
begin
  Result.Clear;
  Result.FVar.FRef := @Result.FVar.FValue;
  Result.FVar.FValue := AValue;
end;

procedure XPVarRef.SetJSON(AValue: string);
begin
  FVar.FRef.SetJSON(AValue);
end;

procedure XPVarRef.SetRef(AValue: PXPVar);
begin
  Clear;
  FVar.FRef := AValue;
  FVar.FValue := AValue^;
end;

procedure XPVarRef.SetValue(AValue: PXPVar);
begin
  Clear;
  FVar.FRef := @FVar.FValue;
  FVar.FValue := AValue^;
end;

procedure XPVarRef.SetValueOfBool(AKey: Boolean; AValue: XPVarRef);
begin
  SetValues(IfThen(AKey, '1', '0'), AValue);
end;

procedure XPVarRef.SetValueOfInt(AKey: Integer; AValue: XPVarRef);
begin
  SetValues(IntToStr(AKey), AValue);
end;

procedure XPVarRef.SetValues(AKey: string; AValue: XPVarRef);
begin
  FVar.FRef.AsArray[AKey] := AValue;
end;

class operator XPVarRef.Subtract(A: XPVarRef; B: Double): XPVarRef;
begin
  Result.Clear;
  Result.FVar.FRef := @Result.FVar.FValue;
  Result.FVar.FValue := A.FVar.FRef^ - B;
end;

class operator XPVarRef.Subtract(A: Double; B: XPVarRef): XPVarRef;
begin
  Result.Clear;
  Result.FVar.FRef := @Result.FVar.FValue;
  Result.FVar.FValue := A - B.FVar.FRef^;
end;

end.
