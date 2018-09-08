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

    procedure TestPointCreateJSONDataWrongObject;
    procedure TestPointCreateJSONDataWrongFormedObjectWithEmptyObject;
    procedure TestPointCreateJSONDataWrongFormedObjectWithMissingMember;

    procedure TestPointCreateJSONI;
    procedure TestPointCreateJSONAltituteI;
    procedure TestPointCreateJSOND;
    procedure TestPointCreateJSONAltituteD;

    procedure TestPointAsJSONI;
    procedure TestPointAsJSONAltitudeI;
    procedure TestPointAsJSOND;
    procedure TestPointAsJSONAltitudeD;
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

  // TGeoJSONPoint
  cJSONPointObjectNoPosition = '{"type": "Point"}';
  cJSONPointObjectI =          '{"type": "Point", "coordinates": [100, -100]}';
  cJSONPointObjectAltitudeI =  '{"type": "Point", "coordinates": [100, -100, 100]}';
  cJSONPointObjectD =          '{"type": "Point", "coordinates": [100.12, -100.12]}';
  cJSONPointObjectAltitudeD =  '{"type": "Point", "coordinates": [100.12, -100.12, 100.12]}';

{ TTestGeoJSONPoint }
procedure TTestGeoJSONPoint.TestPointCreate;
begin
  FGeoJSONPoint:= TGeoJSONPoint.Create;
  AssertEquals('GeoJSON Object type gjtPoint', Ord(FGeoJSONPoint.GJType), Ord(gjtPoint));
  AssertEquals('GeoJSON Object Position Latitude 0 I', 0, FGeoJSONPoint.Coordinates.Latitude);
  AssertEquals('GeoJSON Object Position Longitude 0 I', 0, FGeoJSONPoint.Coordinates.Longitude);
  AssertEquals('GeoJSON Object Position Altitude 0 I', 0, FGeoJSONPoint.Coordinates.Altitude);
  AssertEquals('GeoJSON Object Position HasAltitute False', False, FGeoJSONPoint.Coordinates.HasAltitude);
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
  AssertEquals('Got Exception EPointWrongObject on empty array', True, gotException);
end;

procedure TTestGeoJSONPoint.TestPointCreateJSONDataWrongFormedObjectWithEmptyObject;
var
  gotException: Boolean;
  jData: TJSONData;
begin
  gotException:= False;
  try
    try
      jData:= GetJSONData(cJSONEmptyObject);
      FGeoJSONPoint:= TGeoJSONPoint.Create(jData);
    except
      on e: EPointWrongFormedObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPoint.Free;
  end;
  jData.Free;
  AssertEquals('Got Exception EPointWrongFormedObject on empty object', True, gotException);
end;

procedure TTestGeoJSONPoint.TestPointCreateJSONDataWrongFormedObjectWithMissingMember;
var
  gotException: Boolean;
  jData: TJSONData;
begin
  gotException:= False;
  try
    try
      jData:= GetJSONData(cJSONPointObjectNoPosition);
      FGeoJSONPoint:= TGeoJSONPoint.Create(jData);
    except
      on e: EPointWrongFormedObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPoint.Free;
  end;
  jData.Free;
  AssertEquals('Got Exception EPointWrongFormedObject on empty object', True, gotException);
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
  AssertEquals('Got Exception EPointWrongFormedObject on empty object', True, gotException);
end;

procedure TTestGeoJSONPoint.TestPointCreateJSONI;
begin
  FGeoJSONPoint:= TGeoJSONPoint.Create(cJSONPointObjectI);
  AssertEquals('GeoJSON Object type gjtPoint', Ord(FGeoJSONPoint.GJType), Ord(gjtPoint));
  AssertEquals('GeoJSON Object Position Latitude '+IntToStr(cLatitudeI)+' I', cLatitudeI, FGeoJSONPoint.Coordinates.Latitude);
  AssertEquals('GeoJSON Object Position Longitude '+IntToStr(cLongitudeI)+' I', cLongitudeI, FGeoJSONPoint.Coordinates.Longitude);
  AssertEquals('GeoJSON Object Position Altitude 0 I', 0, FGeoJSONPoint.Coordinates.Altitude);
  AssertEquals('GeoJSON Object Position HasAltitute False', False, FGeoJSONPoint.Coordinates.HasAltitude);
  FGeoJSONPoint.Free;
end;

procedure TTestGeoJSONPoint.TestPointCreateJSONAltituteI;
begin
  FGeoJSONPoint:= TGeoJSONPoint.Create(cJSONPointObjectAltitudeI);
  AssertEquals('GeoJSON Object type gjtPoint', Ord(FGeoJSONPoint.GJType), Ord(gjtPoint));
  AssertEquals('GeoJSON Object Position Latitude '+IntToStr(cLatitudeI)+' I', cLatitudeI, FGeoJSONPoint.Coordinates.Latitude);
  AssertEquals('GeoJSON Object Position Longitude '+IntToStr(cLongitudeI)+' I', cLongitudeI, FGeoJSONPoint.Coordinates.Longitude);
  AssertEquals('GeoJSON Object Position Altitude '+IntToStr(cAltitudeI)+' I', cAltitudeI, FGeoJSONPoint.Coordinates.Altitude);
  AssertEquals('GeoJSON Object Position HasAltitute True', True, FGeoJSONPoint.Coordinates.HasAltitude);
  FGeoJSONPoint.Free;
end;

procedure TTestGeoJSONPoint.TestPointCreateJSOND;
begin
  FGeoJSONPoint:= TGeoJSONPoint.Create(cJSONPointObjectD);
  AssertEquals('GeoJSON Object type gjtPoint', Ord(FGeoJSONPoint.GJType), Ord(gjtPoint));
  AssertEquals('GeoJSON Object Position Latitude '+FloatToStr(cLatitudeD)+' D', cLatitudeD, FGeoJSONPoint.Coordinates.Latitude);
  AssertEquals('GeoJSON Object Position Longitude '+FloatToStr(cLongitudeD)+' D', cLongitudeD, FGeoJSONPoint.Coordinates.Longitude);
  AssertEquals('GeoJSON Object Position Altitude 0 D', 0, FGeoJSONPoint.Coordinates.Altitude);
  AssertEquals('GeoJSON Object Position HasAltitute False', False, FGeoJSONPoint.Coordinates.HasAltitude);
  FGeoJSONPoint.Free;
end;

procedure TTestGeoJSONPoint.TestPointCreateJSONAltituteD;
begin
  FGeoJSONPoint:= TGeoJSONPoint.Create(cJSONPointObjectAltitudeD);
  AssertEquals('GeoJSON Object type gjtPoint', Ord(FGeoJSONPoint.GJType), Ord(gjtPoint));
  AssertEquals('GeoJSON Object Position Latitude '+FloatToStr(cLatitudeD)+' D', cLatitudeD, FGeoJSONPoint.Coordinates.Latitude);
  AssertEquals('GeoJSON Object Position Longitude '+FloatToStr(cLongitudeD)+' D', cLongitudeD, FGeoJSONPoint.Coordinates.Longitude);
  AssertEquals('GeoJSON Object Position Altitude '+FloatToStr(cAltitudeD)+' D', cAltitudeD, FGeoJSONPoint.Coordinates.Altitude);
  AssertEquals('GeoJSON Object Position HasAltitute True', True, FGeoJSONPoint.Coordinates.HasAltitude);
  FGeoJSONPoint.Free;
end;

procedure TTestGeoJSONPoint.TestPointAsJSONI;
begin
  FGeoJSONPoint:= TGeoJSONPoint.Create(cJSONPointObjectI);
  AssertEquals('Point asJSON I', cJSONPointObjectI, FGeoJSONPoint.asJSON);
  FGeoJSONPoint.Free;
end;

procedure TTestGeoJSONPoint.TestPointAsJSONAltitudeI;
begin
  FGeoJSONPoint:= TGeoJSONPoint.Create(cJSONPointObjectAltitudeI);
  AssertEquals('Point asJSON Altitude I', cJSONPointObjectAltitudeI, FGeoJSONPoint.asJSON);
  FGeoJSONPoint.Free;
end;

procedure TTestGeoJSONPoint.TestPointAsJSOND;
begin
  FGeoJSONPoint:= TGeoJSONPoint.Create(cJSONPointObjectD);
  AssertEquals('Point asJSON D', cJSONPointObjectD, FGeoJSONPoint.asJSON);
  FGeoJSONPoint.Free;
end;

procedure TTestGeoJSONPoint.TestPointAsJSONAltitudeD;
begin
  FGeoJSONPoint:= TGeoJSONPoint.Create(cJSONPointObjectAltitudeD);
  AssertEquals('Point asJSON Altitude D', cJSONPointObjectAltitudeD, FGeoJSONPoint.asJSON);
  FGeoJSONPoint.Free;
end;

initialization
  RegisterTest(TTestGeoJSONPoint);
end.

