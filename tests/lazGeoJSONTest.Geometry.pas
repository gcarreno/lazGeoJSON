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
  Classes, SysUtils, fpcunit, {testutils,} testregistry,
  lazGeoJSON,
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
  end;

implementation

const
// TGeoJSONGeometry
  cGeometryEmptyObject = '{}';
  cGeometryObjectNoPosition = '{"type": "Point"}';
  cGeometryObjectI = '{"type": "Point", "coordinates": [100, 100]}';
  cGeometryObjectD = '{"type": "Point", "coordinates": [100.0, 100.0]}';

// TGeoJSONGeometryPosition
  cPositionEmptyObject =            '{}';
  cPositionEmptyObjectEmptyArray =  '{[]}';
  cPositionEmptyArray =             '[]';
  cPositionArrayOneItemI =          '[100]';
  cPositionArrayTwoItemsI =         '[100, 100]';
  cPositionArrayThreeItemsI =       '[100, 100, 100]';
  cPositionArrayFourItemsI =        '[100, 100, 100, 100]';
  cPositionArrayOneItemR =          '[100.0]';
  cPositionArrayTwoItemsR =         '[100.0, 100.0]';
  cPositionArrayThreeItemsR =       '[100.0, 100.0, 100.0]';
  cPositionArrayFourItemsR =        '[100.0, 100.0, 100.0, 100.0]';

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
  AssertEquals('Position Latitude is 0.0', FGeoJSONGeometryPosition.Latitude, 0.0);
  AssertEquals('Position Longitude is 0.0', FGeoJSONGeometryPosition.Longitude, 0.0);
  AssertEquals('Position Altitude is 0.0', FGeoJSONGeometryPosition.Altitude, 0.0);
  AssertEquals('Position Has Altitude is False', FGeoJSONGeometryPosition.HasAltitude, False);
  FGeoJSONGeometryPosition.Free;
end;

initialization
  RegisterTest(TTestGeoJSONGeometry);
end.

