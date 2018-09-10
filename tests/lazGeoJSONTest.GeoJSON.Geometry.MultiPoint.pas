{
  GeoJSON/Geometry/MultiPoint Object Test

  Copyright (c) 2018 Gustavo Carreno <guscarreno@gmail.com>

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to
  deal in the Software without restriction, including without limitation the
  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
  sell copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
  IN THE SOFTWARE.
}
unit lazGeoJSONTest.GeoJSON.Geometry.MultiPoint;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, {testutils,} testregistry, fpjson,
  lazGeoJSON,
  lazGeoJSON.Utils,
  lazGeoJSON.Geometry.MultiPoint;

type

{ TTestGeoJSONMultiPoint }
  TTestGeoJSONMultiPoint= class(TTestCase)
  private
    FGeoJSONMultiPoint: TGeoJSONMultiPoint;
  protected
  public
  published
    procedure TestMultiPointCreate;

    procedure TestMultiPointCreateJSONWrongObject;
    procedure TestMultiPointCreateJSONWrongFormedObjectWithEmptyObject;
    procedure TestMultiPointCreateJSONWrongFormedObjectWithMissingMember;
    procedure TestMultiPointCreateJSON;

    procedure TestMultiPointCreateJSONDataWrongObject;
    procedure TestMultiPointCreateJSONDataWrongFormedObjectWithEmptyObject;
    procedure TestMultiPointCreateJSONDataWrongFormedObjectWithMissingMember;
    procedure TestMultiPointCreateJSONData;

    procedure TestMultiPointCreateJSONObjectWrongFormedObjectWithEmptyObject;
    procedure TestMultiPointCreateJSONObjectWrongFormedObjectWithMissingMember;
    procedure TestMultiPointCreateJSONObject;

    procedure TestMultiPointCreateStreamWrongObject;
    procedure TestMultiPointCreateStreamWrongFormedObjectWithEmptyObject;
    procedure TestMultiPointCreateStreamWrongFormedObjectWithMissingMember;
    procedure TestMultiPointCreateStream;

    procedure TestMultiPointAsJSON;
  end;

implementation

uses
  lazGeoJSONTest.Common;

{ TTestGeoJSONMultiPoint }
procedure TTestGeoJSONMultiPoint.TestMultiPointCreate;
begin
  FGeoJSONMultiPoint:= TGeoJSONMultiPoint.Create;
  AssertEquals('GeoJSON Object type gjtMultiPoint', Ord(FGeoJSONMultiPoint.GeoJSONType), Ord(gjtMultiPoint));
  FGeoJSONMultiPoint.Free;
end;

procedure TTestGeoJSONMultiPoint.TestMultiPointCreateJSONWrongObject;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONMultiPoint:= TGeoJSONMultiPoint.Create(cJSONEmptyArray);
    except
      on e: EMultiPointWrongObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONMultiPoint.Free;
  end;
  AssertEquals('Got Exception EMultiPointWrongObject on empty array', True, gotException);
end;

procedure TTestGeoJSONMultiPoint.TestMultiPointCreateJSONDataWrongObject;
var
  gotException: Boolean;
  jData: TJSONData;
begin
  gotException:= False;
  jData:= GetJSONData(cJSONEmptyArray);
  try
    try
      FGeoJSONMultiPoint:= TGeoJSONMultiPoint.Create(jData);
    except
      on e: EMultiPointWrongObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONMultiPoint.Free;
  end;
  jData.Free;
  AssertEquals('Got Exception EMultiPointWrongObject on empty array', True, gotException);
end;

procedure TTestGeoJSONMultiPoint.TestMultiPointCreateJSONDataWrongFormedObjectWithEmptyObject;
var
  gotException: Boolean;
  jData: TJSONData;
begin
  gotException:= False;
  try
    try
      jData:= GetJSONData(cJSONEmptyObject);
      FGeoJSONMultiPoint:= TGeoJSONMultiPoint.Create(jData);
    except
      on e: EMultiPointWrongFormedObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONMultiPoint.Free;
  end;
  jData.Free;
  AssertEquals('Got Exception EMultiPointWrongFormedObject on empty object', True, gotException);
end;

procedure TTestGeoJSONMultiPoint.TestMultiPointCreateJSONDataWrongFormedObjectWithMissingMember;
var
  gotException: Boolean;
  jData: TJSONData;
begin
  gotException:= False;
  try
    try
      jData:= GetJSONData(cJSONMultiPointObjectNoPosition);
      FGeoJSONMultiPoint:= TGeoJSONMultiPoint.Create(jData);
    except
      on e: EMultiPointWrongFormedObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONMultiPoint.Free;
  end;
  jData.Free;
  AssertEquals('Got Exception EMultiPointWrongFormedObject on object missing member', True, gotException);
end;

procedure TTestGeoJSONMultiPoint.TestMultiPointCreateJSONObjectWrongFormedObjectWithEmptyObject;
var
  gotException: Boolean;
  jData: TJSONData;
begin
  gotException:= False;
  try
    try
      jData:= GetJSONData(cJSONEmptyObject);
      FGeoJSONMultiPoint:= TGeoJSONMultiPoint.Create(jData as TJSONObject);
    except
      on e: EMultiPointWrongFormedObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONMultiPoint.Free;
  end;
  jData.Free;
  AssertEquals('Got Exception EMultiPointWrongFormedObject on empty object', True, gotException);
end;

procedure TTestGeoJSONMultiPoint.TestMultiPointCreateJSONObjectWrongFormedObjectWithMissingMember;
var
  gotException: Boolean;
  jData: TJSONData;
begin
  gotException:= False;
  try
    try
      jData:= GetJSONData(cJSONMultiPointObjectNoPosition);
      FGeoJSONMultiPoint:= TGeoJSONMultiPoint.Create(jData as TJSONObject);
    except
      on e: EMultiPointWrongFormedObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONMultiPoint.Free;
  end;
  jData.Free;
  AssertEquals('Got Exception EMultiPointWrongFormedObject on object missing member', True, gotException);
end;

procedure TTestGeoJSONMultiPoint.TestMultiPointCreateJSONObject;
var
  jData: TJSONData;
begin
  jData:= GetJSONData(cJSONMultiPointObjectOnePoint);
  FGeoJSONMultiPoint:= TGeoJSONMultiPoint.Create(jData as TJSONObject);
  AssertEquals('GeoJSON Object type gjtMultiPoint', Ord(FGeoJSONMultiPoint.GeoJSONType), Ord(gjtMultiPoint));
  FGeoJSONMultiPoint.Free;
  jdata.Free;
end;

procedure TTestGeoJSONMultiPoint.TestMultiPointCreateStreamWrongObject;
var
  gotException: Boolean;
  s: TStringStream;
begin
  s:= TStringStream.Create(cJSONEmptyArray);
  gotException:= False;
  try
    try
      FGeoJSONMultiPoint:= TGeoJSONMultiPoint.Create(s);
    except
      on e: EMultiPointWrongObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONMultiPoint.Free;
  end;
  s.Free;
  AssertEquals('Got Exception EMultiPointWrongObject on empty array', True, gotException);
end;

procedure TTestGeoJSONMultiPoint.TestMultiPointCreateStreamWrongFormedObjectWithEmptyObject;
var
  gotException: Boolean;
  s: TStringStream;
begin
  s:= TStringStream.Create(cJSONEmptyObject);
  gotException:= False;
  try
    try
      FGeoJSONMultiPoint:= TGeoJSONMultiPoint.Create(s);
    except
      on e: EMultiPointWrongFormedObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONMultiPoint.Free;
  end;
  s.Free;
  AssertEquals('Got Exception EMultiPointWrongFormedObject on empty object', True, gotException);
end;

procedure TTestGeoJSONMultiPoint.TestMultiPointCreateStreamWrongFormedObjectWithMissingMember;
var
  gotException: Boolean;
  s: TStringStream;
begin
  s:= TStringStream.Create(cJSONMultiPointObjectNoPosition);
  gotException:= False;
  try
    try
      FGeoJSONMultiPoint:= TGeoJSONMultiPoint.Create(s);
    except
      on e: EMultiPointWrongFormedObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONMultiPoint.Free;
  end;
  s.Free;
  AssertEquals('Got Exception EMultiPointWrongFormedObject on object missing member', True, gotException);
end;

procedure TTestGeoJSONMultiPoint.TestMultiPointCreateStream;
var
  s: TStringStream;
begin
  s:= TStringStream.Create(cJSONMultiPointObjectOnePoint);
  FGeoJSONMultiPoint:= TGeoJSONMultiPoint.Create(s);
  AssertEquals('GeoJSON Object type gjtMultiPoint', Ord(FGeoJSONMultiPoint.GeoJSONType), Ord(gjtMultiPoint));
  FGeoJSONMultiPoint.Free;
  s.Free;
end;

procedure TTestGeoJSONMultiPoint.TestMultiPointCreateJSONWrongFormedObjectWithEmptyObject;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONMultiPoint:= TGeoJSONMultiPoint.Create(cJSONEmptyObject);
    except
      on e: EMultiPointWrongFormedObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONMultiPoint.Free;
  end;
  AssertEquals('Got Exception EMultiPointWrongFormedObject on empty object', True, gotException);
end;

procedure TTestGeoJSONMultiPoint.TestMultiPointCreateJSONWrongFormedObjectWithMissingMember;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONMultiPoint:= TGeoJSONMultiPoint.Create(cJSONMultiPointObjectNoPosition);
    except
      on e: EMultiPointWrongFormedObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONMultiPoint.Free;
  end;
  AssertEquals('Got Exception EMultiMultiPointWrongFormedObject on object missing member', True, gotException);
end;

procedure TTestGeoJSONMultiPoint.TestMultiPointCreateJSON;
begin
  FGeoJSONMultiPoint:= TGeoJSONMultiPoint.Create(cJSONMultiPointObjectOnePoint);
  AssertEquals('GeoJSON Object type gjtMultiPoint', Ord(FGeoJSONMultiPoint.GeoJSONType), Ord(gjtMultiPoint));
  FGeoJSONMultiPoint.Free;
end;

procedure TTestGeoJSONMultiPoint.TestMultiPointCreateJSONData;
var
  jData: TJSONData;
begin
  jData:= GetJSONData(cJSONMultiPointObjectOnePoint);
  FGeoJSONMultiPoint:= TGeoJSONMultiPoint.Create(jData);
  AssertEquals('GeoJSON Object type gjtMultiPoint', Ord(FGeoJSONMultiPoint.GeoJSONType), Ord(gjtMultiPoint));
  FGeoJSONMultiPoint.Free;
  jdata.Free;
end;

procedure TTestGeoJSONMultiPoint.TestMultiPointAsJSON;
begin
  FGeoJSONMultiPoint:= TGeoJSONMultiPoint.Create(cJSONMultiPointObjectOnePoint);
  AssertEquals('MultiPoint asJSON I', cJSONMultiPointObjectOnePoint, FGeoJSONMultiPoint.asJSON);
  FGeoJSONMultiPoint.Free;
end;

initialization
  RegisterTest(TTestGeoJSONMultiPoint);
end.

