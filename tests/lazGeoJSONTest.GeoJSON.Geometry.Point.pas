{
  GeoJSON/Geometry/Point Object Test

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
unit lazGeoJSONTest.GeoJSON.Geometry.Point;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, {testutils,} testregistry, fpjson,
  lazGeoJSON,
  lazGeoJSON.Utils,
  lazGeoJSON.Geometry.Point;

type

{ TTestGeoJSONPoint }
  TTestGeoJSONPoint= class(TTestCase)
  private
    FGeoJSONPoint: TGeoJSONPoint;
  protected
  public
  published
    procedure TestPointCreate;

    procedure TestPointCreateJSONWrongObject;
    procedure TestPointCreateJSONWrongFormedObjectWithEmptyObject;
    procedure TestPointCreateJSONWrongFormedObjectWithMissingMember;
    procedure TestPointCreateJSON;

    procedure TestPointCreateJSONDataWrongObject;
    procedure TestPointCreateJSONDataWrongFormedObjectWithEmptyObject;
    procedure TestPointCreateJSONDataWrongFormedObjectWithMissingMember;
    procedure TestPointCreateJSONData;

    procedure TestPointCreateJSONObjectWrongFormedObjectWithEmptyObject;
    procedure TestPointCreateJSONObjectWrongFormedObjectWithMissingMember;
    procedure TestPointCreateJSONObject;

    procedure TestPointCreateStreamWrongObject;
    procedure TestPointCreateStreamWrongFormedObjectWithEmptyObject;
    procedure TestPointCreateStreamWrongFormedObjectWithMissingMember;
    procedure TestPointCreateStream;

    procedure TestPointAsJSON;
  end;

implementation

uses
  lazGeoJSONTest.Common;

{ TTestGeoJSONPoint }
procedure TTestGeoJSONPoint.TestPointCreate;
begin
  FGeoJSONPoint:= TGeoJSONPoint.Create;
  AssertEquals('GeoJSON Object type gjtPoint', Ord(FGeoJSONPoint.GeoJSONType), Ord(gjtPoint));
  FGeoJSONPoint.Free;
end;

procedure TTestGeoJSONPoint.TestPointCreateJSONWrongObject;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONPoint:= TGeoJSONPoint.Create(cJSONEmptyArray);
    except
      on e: EPointWrongObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPoint.Free;
  end;
  AssertEquals('Got Exception EPointWrongObject on empty array', True, gotException);
end;

procedure TTestGeoJSONPoint.TestPointCreateJSONDataWrongObject;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONPoint:= TGeoJSONPoint.Create(GetJSONData(cJSONEmptyArray));
    except
      on e: EPointWrongObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPoint.Free;
  end;
  AssertEquals('Got Exception EPointWrongObject on empty array', True, gotException);
end;

procedure TTestGeoJSONPoint.TestPointCreateJSONDataWrongFormedObjectWithEmptyObject;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONPoint:= TGeoJSONPoint.Create(GetJSONData(cJSONEmptyObject));
    except
      on e: EPointWrongFormedObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPoint.Free;
  end;
  AssertEquals('Got Exception EPointWrongFormedObject on empty object', True, gotException);
end;

procedure TTestGeoJSONPoint.TestPointCreateJSONDataWrongFormedObjectWithMissingMember;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONPoint:= TGeoJSONPoint.Create(GetJSONData(cJSONPointObjectNoPosition));
    except
      on e: EPointWrongFormedObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPoint.Free;
  end;
  AssertEquals('Got Exception EPointWrongFormedObject on object missing member', True, gotException);
end;

procedure TTestGeoJSONPoint.TestPointCreateJSONObjectWrongFormedObjectWithEmptyObject;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONPoint:= TGeoJSONPoint.Create(GetJSONData(cJSONEmptyObject) as TJSONObject);
    except
      on e: EPointWrongFormedObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPoint.Free;
  end;
  AssertEquals('Got Exception EPointWrongFormedObject on empty object', True, gotException);
end;

procedure TTestGeoJSONPoint.TestPointCreateJSONObjectWrongFormedObjectWithMissingMember;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONPoint:= TGeoJSONPoint.Create(GetJSONData(cJSONPointObjectNoPosition) as TJSONObject);
    except
      on e: EPointWrongFormedObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPoint.Free;
  end;
  AssertEquals('Got Exception EPointWrongFormedObject on object missing member', True, gotException);
end;

procedure TTestGeoJSONPoint.TestPointCreateJSONObject;
begin
  FGeoJSONPoint:= TGeoJSONPoint.Create(GetJSONData(cJSONPointObject) as TJSONObject);
  AssertEquals('GeoJSON Object type gjtPoint', Ord(FGeoJSONPoint.GeoJSONType), Ord(gjtPoint));
  FGeoJSONPoint.Free;
end;

procedure TTestGeoJSONPoint.TestPointCreateStreamWrongObject;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONPoint:= TGeoJSONPoint.Create(TStringStream.Create(cJSONEmptyArray));
    except
      on e: EPointWrongObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPoint.Free;
  end;
  AssertEquals('Got Exception EPointWrongObject on empty array', True, gotException);
end;

procedure TTestGeoJSONPoint.TestPointCreateStreamWrongFormedObjectWithEmptyObject;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONPoint:= TGeoJSONPoint.Create(TStringStream.Create(cJSONEmptyObject));
    except
      on e: EPointWrongFormedObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPoint.Free;
  end;
  AssertEquals('Got Exception EPointWrongFormedObject on empty object', True, gotException);
end;

procedure TTestGeoJSONPoint.TestPointCreateStreamWrongFormedObjectWithMissingMember;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONPoint:= TGeoJSONPoint.Create(TStringStream.Create(cJSONPointObjectNoPosition));
    except
      on e: EPointWrongFormedObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPoint.Free;
  end;
  AssertEquals('Got Exception EPointWrongFormedObject on object missing member', True, gotException);
end;

procedure TTestGeoJSONPoint.TestPointCreateStream;
begin
  FGeoJSONPoint:= TGeoJSONPoint.Create(TStringStream.Create(cJSONPointObject));
  AssertEquals('GeoJSON Object type gjtPoint', Ord(FGeoJSONPoint.GeoJSONType), Ord(gjtPoint));
  FGeoJSONPoint.Free;
end;

procedure TTestGeoJSONPoint.TestPointCreateJSONWrongFormedObjectWithEmptyObject;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONPoint:= TGeoJSONPoint.Create(cJSONEmptyObject);
    except
      on e: EPointWrongFormedObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPoint.Free;
  end;
  AssertEquals('Got Exception EPointWrongFormedObject on empty object', True, gotException);
end;

procedure TTestGeoJSONPoint.TestPointCreateJSONWrongFormedObjectWithMissingMember;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONPoint:= TGeoJSONPoint.Create(cJSONPointObjectNoPosition);
    except
      on e: EPointWrongFormedObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPoint.Free;
  end;
  AssertEquals('Got Exception EPointWrongFormedObject on object missing member', True, gotException);
end;

procedure TTestGeoJSONPoint.TestPointCreateJSON;
begin
  FGeoJSONPoint:= TGeoJSONPoint.Create(cJSONPointObject);
  AssertEquals('GeoJSON Object type gjtPoint', Ord(FGeoJSONPoint.GeoJSONType), Ord(gjtPoint));
  FGeoJSONPoint.Free;
end;

procedure TTestGeoJSONPoint.TestPointCreateJSONData;
begin
  FGeoJSONPoint:= TGeoJSONPoint.Create(GetJSONData(cJSONPointObject));
  AssertEquals('GeoJSON Object type gjtPoint', Ord(FGeoJSONPoint.GeoJSONType), Ord(gjtPoint));
  FGeoJSONPoint.Free;
end;

procedure TTestGeoJSONPoint.TestPointAsJSON;
begin
  FGeoJSONPoint:= TGeoJSONPoint.Create(cJSONPointObject);
  AssertEquals('Point asJSON I', cJSONPointObject, FGeoJSONPoint.asJSON);
  FGeoJSONPoint.Free;
end;

initialization
  RegisterTest(TTestGeoJSONPoint);
end.

