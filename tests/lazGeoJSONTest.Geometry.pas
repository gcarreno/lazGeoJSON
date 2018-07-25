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
    procedure TestPositionCreateJSONArray;
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
  cJSONPositionArrayTwoItemsI =   '[100, 100]';
  cJSONPositionArrayThreeItemsI = '[100, 100, 100]';
  cJSONPositionArrayFourItemsI =  '[100, 100, 100, 100]';
  cJSONPositionArrayOneItemR =    '[100.0]';
  cJSONPositionArrayTwoItemsR =   '[100.0, 100.0]';
  cJSONPositionArrayThreeItemsR = '[100.0, 100.0, 100.0]';
  cJSONPositionArrayFourItemsR =  '[100.0, 100.0, 100.0, 100.0]';

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

procedure TTestGeoJSONGeometry.TestPositionCreateJSONArray;
var
  jData: TJSONData;
  jArray: TJSONArray;
  gotException: Boolean;
begin
  jData:= GetJSONData(cJSONEmptyArray);
  jArray:= TJSONArray(jData);
  gotException:= False;
  try
    try
      FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(jArray);
    except
      on e: ENotEnoughItems do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONGeometryPosition.Free;
  end;
  AssertEquals('Got Exception ENotEnoughItems', True, gotException);
end;

initialization
  RegisterTest(TTestGeoJSONGeometry);
end.

