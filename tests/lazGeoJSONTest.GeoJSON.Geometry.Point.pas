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
{ TTestGeoJSONGeometryPoint }
  TTestGeoJSONGeometryPoint= class(TTestCase)
  private
    FGeoJSONPoint: TGeoJSONPoint;
  protected
  public
  published
    procedure TestPointCreate;

    procedure TestPointCreateJSONWrongObject;
    procedure TestPointCreateJSONDataWrongObject;
  end;

implementation

const
  cJSONEmptyObject =            '{}';
  cJSONEmptyObjectEmptyArray =  '{[]}';
  cJSONEmptyArray =             '[]';

  // TGeoJSONPoint
  cJSONPointObjectNoPosition = '{"type": "Point"}';
  cJSONPointObjectI =          '{"type": "Point", "coordinates": [100, 100]}';
  cJSONPointObjectD =          '{"type": "Point", "coordinates": [100.12, 100.12]}';

{ TTestGeoJSONGeometryPoint }
procedure TTestGeoJSONGeometryPoint.TestPointCreate;
begin
  FGeoJSONPoint:= TGeoJSONPoint.Create;
  AssertEquals('GeoJSON Object type gjtPoint', Ord(FGeoJSONPoint.GJType), Ord(gjtPoint));
  AssertEquals('GeoJSON Object Position Latitude 0 I', 0, FGeoJSONPoint.Coordinates.Latitude);
  AssertEquals('GeoJSON Object Position Longitude 0 I', 0, FGeoJSONPoint.Coordinates.Longitude);
  AssertEquals('GeoJSON Object Position Altitude 0 I', 0, FGeoJSONPoint.Coordinates.Altitude);
  AssertEquals('GeoJSON Object Position HasAltitute False', False, FGeoJSONPoint.Coordinates.HasAltitude);
  FGeoJSONPoint.Free;
end;

procedure TTestGeoJSONGeometryPoint.TestPointCreateJSONWrongObject;
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

procedure TTestGeoJSONGeometryPoint.TestPointCreateJSONDataWrongObject;
var
  gotException: Boolean;
  jData: TJSONData;
begin
  gotException:= False;
  jData:= GetJSONData(cJSONEmptyArray);
  try
    try
      FGeoJSONPoint:= TGeoJSONPoint.Create(jData);
    except
      on e: EPointWrongObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPoint.Free;
  end;
  jData.Free;
  AssertEquals('Got Exception EGeometryWrongObject on empty array', True, gotException);
end;

initialization
  RegisterTest(TTestGeoJSONGeometryPoint);
end.

