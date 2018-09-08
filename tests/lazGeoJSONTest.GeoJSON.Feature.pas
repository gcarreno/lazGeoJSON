{
  GeoJSON/Feature Object Test

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
unit lazGeoJSONTest.GeoJSON.Feature;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, {testutils,} testregistry, fpjson,
  lazGeoJSON,
  lazGeoJSON.Utils,
  lazGeoJSON.Feature;

type

{ TTestGeoJSONFeature }
  TTestGeoJSONFeature = class(TTestCase)
  private
    FGeoJSONFeature: TGeoJSONFeature;
  protected
  public
  published
    procedure TestFeatureCreate;
  end;

implementation

const
  cJSONEmptyObject =            '{}';
  cJSONEmptyArray =             '[]';

// Float and Integer Constants
  cLatitudeI = 100;
  cLongitudeI = -100;
  cAltitudeI = 100;
  cLatitudeD = 100.12;
  cLongitudeD = -100.12;
  cAltitudeD = 100.12;

// TGeoJSONFeature
  cJSONFeatureNoGeometry =
    '{"type": "Feature"}';
  cJSONFeatureI =
    '{"type": "Feature", "geometry": {"type": "Point", "coordinates": [100, -100]}}';
  cJSONFeatureAltitudeI =
    '{"type": "Feature", "geometry": {"type": "Point", "coordinates": [100, -100, 100]}}';

{ TTestGeoJSONFeature }

procedure TTestGeoJSONFeature.TestFeatureCreate;
begin
  FGeoJSONFeature:= TGeoJSONFeature.Create;
  AssertEquals('GeoJSON Object Type gjtFeature', Ord(gjtFeature), Ord(FGeoJSONFeature.GJType));
  AssertEquals('GeoJSON Object Position Latitude 0 I', 0, FGeoJSONFeature.Point.Coordinates.Latitude);
  AssertEquals('GeoJSON Object Position Longitude 0 I', 0, FGeoJSONFeature.Point.Coordinates.Longitude);
  AssertEquals('GeoJSON Object Position Altitude 0 I', 0, FGeoJSONFeature.Point.Coordinates.Altitude);
  AssertEquals('GeoJSON Object Position HasAltitute False', False, FGeoJSONFeature.Point.Coordinates.HasAltitude);
  FGeoJSONFeature.Free;
end;

initialization
  RegisterTest(TTestGeoJSONFeature);
end.
