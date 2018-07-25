{
  GeoJSON/Geometry Object Test

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
unit lazGeoJSONTest.Geometry;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, {testutils,} testregistry, fpjson,
  lazGeoJSON,
  lazGeoJSON.Utils,
  lazGeoJSON.Geometry;

type
{ TTestGeoJSONGeometry }
  TTestGeoJSONGeometry = class(TTestCase)
  private
    FGeoJSONGeometry: TGeoJSONGeometry;
    FGeoJSONGeometryPosition: TGeoJSONGeometryPosition;
  protected
  public
  published
    procedure TestGeometryCreate;
    procedure TestPositionCreate;
    procedure TestPositionCreateJSONArrayENotEnoughItemsEmptyArray;
    procedure TestPositionCreateJSONArrayENotEnoughItemsOneItemI;
    procedure TestPositionCreateJSONArrayENotEnoughItemsOneItemD;
    procedure TestPositionCreateJSONArrayTwoItemsI;
    procedure TestPositionCreateJSONArrayTwoItemsD;
    procedure TestPositionCreateJSONArrayThreeItemsI;
    procedure TestPositionCreateJSONArrayThreeItemsD;
    procedure TestPositionCreateJSONArrayFourItemsI;
    procedure TestPositionCreateJSONArrayFourItemsD;
  end;

implementation

const
  cJSONEmptyObject =            '{}';
  cJSONEmptyObjectEmptyArray =  '{[]}';
  cJSONEmptyArray =             '[]';
// TGeoJSONGeometry
  cJSONGeometryObjectNoPosition = '{"type": "Point"}';
  cJSONGeometryObjectI =          '{"type": "Point", "coordinates": [100, 100]}';
  cJSONGeometryObjectD =          '{"type": "Point", "coordinates": [100.0, 100.0]}';

// TGeoJSONGeometryPosition
  cJSONPositionArrayOneItemI =    '[100]';
  cJSONPositionArrayTwoItemsI =   '[100, -100]';
  cJSONPositionArrayThreeItemsI = '[100, -100, 100]';
  cJSONPositionArrayFourItemsI =  '[100, -100, 100, 100]';
  cJSONPositionArrayOneItemD =    '[100.0]';
  cJSONPositionArrayTwoItemsD =   '[100.0, -100.0]';
  cJSONPositionArrayThreeItemsD = '[100.0, -100.0, 100.0]';
  cJSONPositionArrayFourItemsD =  '[100.0, -100.0, 100.0, 100.0]';

{ TTestGeoJSONGeometry }
procedure TTestGeoJSONGeometry.TestGeometryCreate;
begin
  FGeoJSONGeometry:= TGeoJSONGeometry.Create;
  AssertEquals('GeoJSON Object type gjtNone', Ord(FGeoJSONGeometry.GJType), Ord(gjtNone));
  FGeoJSONGeometry.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreate;
begin
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create;
  AssertEquals('Position Latitude is 0.0', 0.0, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is 0.0', 0.0, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 0.0', 0.0, FGeoJSONGeometryPosition.Altitude);
  AssertEquals('Position Has Altitude is False', False, FGeoJSONGeometryPosition.HasAltitude);
  FGeoJSONGeometryPosition.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateJSONArrayENotEnoughItemsEmptyArray;
var
  jData: TJSONData;
  gotException: Boolean;
begin
  jData:= GetJSONData(cJSONEmptyArray);
  gotException:= False;
  try
    try
      FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(TJSONArray(jData));
    except
      on e: ENotEnoughItems do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONGeometryPosition.Free;
  end;
  AssertEquals('Got Exception ENotEnoughItems on empty array', True, gotException);
  jData.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateJSONArrayENotEnoughItemsOneItemI;
var
  jData: TJSONData;
  gotException: Boolean;
begin
  jData:= GetJSONData(cJSONPositionArrayOneItemI);
  gotException:= False;
  try
    try
      FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(TJSONArray(jData));
    except
      on e: ENotEnoughItems do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONGeometryPosition.Free;
  end;
  AssertEquals('Got Exception ENotEnoughItems on one item I', True, gotException);
  jData.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateJSONArrayENotEnoughItemsOneItemD;
var
  jData: TJSONData;
  gotException: Boolean;
begin
  jData:= GetJSONData(cJSONPositionArrayOneItemD);
  gotException:= False;
  try
    try
      FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(TJSONArray(jData));
    except
      on e: ENotEnoughItems do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONGeometryPosition.Free;
  end;
  AssertEquals('Got Exception ENotEnoughItems on one item D', True, gotException);
  jData.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateJSONArrayTwoItemsI;
var
  jData: TJSONData;
begin
  jData:= GetJSONData(cJSONPositionArrayTwoItemsI);
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(TJSONArray(jData));
  AssertEquals('Position Latitude is 100 I', 100.0, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is -100 I', -100.0, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 0 I', 0.0, FGeoJSONGeometryPosition.Altitude);
  AssertEquals('Position Has Altitude is False I', False, FGeoJSONGeometryPosition.HasAltitude);
  FGeoJSONGeometryPosition.Free;
  jData.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateJSONArrayTwoItemsD;
var
  jData: TJSONData;
begin
  jData:= GetJSONData(cJSONPositionArrayTwoItemsD);
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(TJSONArray(jData));
  AssertEquals('Position Latitude is 100 D', 100.0, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is -100 D', -100.0, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 0 D', 0.0, FGeoJSONGeometryPosition.Altitude);
  AssertEquals('Position Has Altitude is False D', False, FGeoJSONGeometryPosition.HasAltitude);
  FGeoJSONGeometryPosition.Free;
  jData.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateJSONArrayThreeItemsI;
var
  jData: TJSONData;
begin
  jData:= GetJSONData(cJSONPositionArrayThreeItemsI);
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(TJSONArray(jData));
  AssertEquals('Position Latitude is 100 I', 100.0, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is -100 I', -100.0, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 100 I', 100.0, FGeoJSONGeometryPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONGeometryPosition.HasAltitude);
  FGeoJSONGeometryPosition.Free;
  jData.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateJSONArrayThreeItemsD;
var
  jData: TJSONData;
begin
  jData:= GetJSONData(cJSONPositionArrayThreeItemsD);
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(TJSONArray(jData));
  AssertEquals('Position Latitude is 100 D', 100.0, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is -100 D', -100.0, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 100 D', 100.0, FGeoJSONGeometryPosition.Altitude);
  AssertEquals('Position Has Altitude is True D', True, FGeoJSONGeometryPosition.HasAltitude);
  FGeoJSONGeometryPosition.Free;
  jData.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateJSONArrayFourItemsI;
var
  jData: TJSONData;
begin
  jData:= GetJSONData(cJSONPositionArrayFourItemsI);
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(TJSONArray(jData));
  AssertEquals('Position Latitude is 100 I', 100.0, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is -100 I', -100.0, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 100 I', 100.0, FGeoJSONGeometryPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONGeometryPosition.HasAltitude);
  FGeoJSONGeometryPosition.Free;
  jData.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateJSONArrayFourItemsD;
var
  jData: TJSONData;
begin
  jData:= GetJSONData(cJSONPositionArrayFourItemsD);
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(TJSONArray(jData));
  AssertEquals('Position Latitude is 100 D', 100.0, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is -100 D', -100.0, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 100 D', 100.0, FGeoJSONGeometryPosition.Altitude);
  AssertEquals('Position Has Altitude is True D', True, FGeoJSONGeometryPosition.HasAltitude);
  FGeoJSONGeometryPosition.Free;
  jData.Free;
end;

initialization
  RegisterTest(TTestGeoJSONGeometry);
end.

