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
  lazGeoJSON.Geometry,
  lazGeoJSON.Geometry.Position;

type
{ TTestGeoJSONGeometry }
  TTestGeoJSONGeometry = class(TTestCase)
  private
    FGeoJSONGeometry: TGeoJSONGeometry;
    FGeoJSONGeometryPosition: TGeoJSONPosition;
  protected
  public
  published
    procedure TestGeometryCreate;

    procedure TestGeometryCreateJSONWrongObject;
    procedure TestGeometryCreateJSONDataWrongObject;

  end;

implementation

const
  cJSONEmptyObject =            '{}';
  cJSONEmptyObjectEmptyArray =  '{[]}';
  cJSONEmptyArray =             '[]';

  // TGeoJSONGeometry
  cJSONGeometryObjectNoPosition = '{"type": "Point"}';
  cJSONGeometryObjectI =          '{"type": "Point", "coordinates": [100, 100]}';
  cJSONGeometryObjectD =          '{"type": "Point", "coordinates": [100.12, 100.12]}';

{ TTestGeoJSONGeometry }
procedure TTestGeoJSONGeometry.TestGeometryCreate;
begin
  {FGeoJSONGeometry:= TGeoJSONGeometry.Create;
  AssertEquals('GeoJSON Object type gjtNone', Ord(FGeoJSONGeometry.GJType), Ord(gjtNone));
  AssertEquals('GeoJSON Object Position Latitude 0 I', 0, FGeoJSONGeometry.Position.Latitude);
  AssertEquals('GeoJSON Object Position Longitude 0 I', 0, FGeoJSONGeometry.Position.Longitude);
  AssertEquals('GeoJSON Object Position Altitude 0 I', 0, FGeoJSONGeometry.Position.Altitude);
  AssertEquals('GeoJSON Object Position HasAltitute False', False, FGeoJSONGeometry.Position.HasAltitude);
  FGeoJSONGeometry.Free;}
end;

procedure TTestGeoJSONGeometry.TestGeometryCreateJSONWrongObject;
var
  gotException: Boolean;
begin
  {gotException:= False;
  try
    try
      FGeoJSONGeometry:= TGeoJSONGeometry.Create(cJSONEmptyArray);
    except
      on e: EGeometryWrongObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONGeometry.Free;
  end;
  AssertEquals('Got Exception EGeometryWrongObject on empty array', True, gotException);}
end;

procedure TTestGeoJSONGeometry.TestGeometryCreateJSONDataWrongObject;
var
  gotException: Boolean;
  jData: TJSONData;
begin
  {gotException:= False;
  jData:= GetJSONData(cJSONEmptyArray);
  try
    try
      FGeoJSONGeometry:= TGeoJSONGeometry.Create(jData);
    except
      on e: EGeometryWrongObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONGeometry.Free;
  end;
  jData.Free;
  AssertEquals('Got Exception EGeometryWrongObject on empty array', True, gotException);}
end;

initialization
  RegisterTest(TTestGeoJSONGeometry);
end.

