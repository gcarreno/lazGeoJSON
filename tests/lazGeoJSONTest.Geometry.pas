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

    procedure TestPositionCreateJSONDataWrongObject;
    procedure TestPositionCreateJSONDataENotEnoughItemsEmptyArray;
    procedure TestPositionCreateJSONDataENotEnoughItemsOneItemI;
    procedure TestPositionCreateJSONDataENotEnoughItemsOneItemD;
    procedure TestPositionCreateJSONDataTwoItemsI;
    procedure TestPositionCreateJSONDataTwoItemsD;
    procedure TestPositionCreateJSONDataThreeItemsI;
    procedure TestPositionCreateJSONDataThreeItemsD;
    procedure TestPositionCreateJSONDataFourItemsI;
    procedure TestPositionCreateJSONDataFourItemsD;

    procedure TestPositionCreateJSONWrongObject;
    procedure TestPositionCreateJSONENotEnoughItemsEmptyArray;
    procedure TestPositionCreateJSONENotEnoughItemsOneItemI;
    procedure TestPositionCreateJSONENotEnoughItemsOneItemD;
    procedure TestPositionCreateJSONTwoItemsI;
    procedure TestPositionCreateJSONTwoItemsD;
    procedure TestPositionCreateJSONThreeItemsI;
    procedure TestPositionCreateJSONThreeItemsD;
    procedure TestPositionCreateJSONFourItemsI;
    procedure TestPositionCreateJSONFourItemsD;

    procedure TestPositionCreateStreamWrongObject;
    procedure TestPositionCreateStreamENotEnoughItemsEmptyArray;
    procedure TestPositionCreateStreamENotEnoughItemsOneItemI;
    procedure TestPositionCreateStreamENotEnoughItemsOneItemD;
    procedure TestPositionCreateStreamTwoItemsI;
    procedure TestPositionCreateStreamTwoItemsD;
    procedure TestPositionCreateStreamThreeItemsI;
    procedure TestPositionCreateStreamThreeItemsD;
    procedure TestPositionCreateStreamFourItemsI;
    procedure TestPositionCreateStreamFourItemsD;

    procedure TestPositionAsJSONI;
    procedure TestPositionAsJSONAltitudeI;
    procedure TestPositionAsJSOND;
    procedure TestPositionAsJSONAltitudeD;
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
  cJSONPositionArrayOneItemD =    '[100.1]';
  cJSONPositionArrayTwoItemsD =   '[100.1, -100.1]';
  cJSONPositionArrayThreeItemsD = '[100.1, -100.1, 100.1]';
  cJSONPositionArrayFourItemsD =  '[100.1, -100.1, 100.1, 100.1]';
  cLatitudeI = 100;
  cLongitudeI = -100;
  cAltitudeI = 100;
  cLatitudeD = 100.1;
  cLongitudeD = -100.1;
  cAltitudeD = 100.1;

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
  AssertEquals('Position Latitude is '+IntToStr(cLatitudeI)+' I', cLatitudeI, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is '+IntToStr(cLongitudeI)+' I', cLongitudeI, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 0 I', 0, FGeoJSONGeometryPosition.Altitude);
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
  AssertEquals('Position Latitude is '+FloatToStr(cLatitudeD)+' D', cLatitudeD, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is '+FloatToStr(cLongitudeD)+' D', cLongitudeD, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 0.0 D', 0.0, FGeoJSONGeometryPosition.Altitude);
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
  AssertEquals('Position Latitude is '+IntToStr(cLatitudeI)+' I', cLatitudeI, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is '+IntToStr(cLongitudeI)+' I', cLongitudeI, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is '+IntToStr(cAltitudeI)+' I', cAltitudeI, FGeoJSONGeometryPosition.Altitude);
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
  AssertEquals('Position Latitude is '+FloatToStr(cLatitudeD)+' D', cLatitudeD, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is '+FloatToStr(cLongitudeD)+' D', cLongitudeD, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is '+FloatToStr(cAltitudeD)+' D', cAltitudeD, FGeoJSONGeometryPosition.Altitude);
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
  AssertEquals('Position Latitude is 100 I', 100, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is -100 I', -100, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 100 I', 100, FGeoJSONGeometryPosition.Altitude);
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
  AssertEquals('Position Latitude is 100.1 D', 100.1, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is -100.1 D', -100.1, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 100.1 D', 100.1, FGeoJSONGeometryPosition.Altitude);
  AssertEquals('Position Has Altitude is True D', True, FGeoJSONGeometryPosition.HasAltitude);
  FGeoJSONGeometryPosition.Free;
  jData.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateJSONDataWrongObject;
var
  jData: TJSONData;
  gotException: Boolean;
begin
  jData:= GetJSONData(cJSONEmptyObject);
  gotException:= False;
  try
    try
      FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(jData);
    except
      on e: EWrongJSONObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONGeometryPosition.Free;
  end;
  AssertEquals('Got Exception EWrongJSONObject on empty object', True, gotException);
  jData.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateJSONDataENotEnoughItemsEmptyArray;
var
  jData: TJSONData;
  gotException: Boolean;
begin
  jData:= GetJSONData(cJSONEmptyArray);
  gotException:= False;
  try
    try
      FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(jData);
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

procedure TTestGeoJSONGeometry.TestPositionCreateJSONDataENotEnoughItemsOneItemI;
var
  jData: TJSONData;
  gotException: Boolean;
begin
  jData:= GetJSONData(cJSONPositionArrayOneItemI);
  gotException:= False;
  try
    try
      FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(jData);
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

procedure TTestGeoJSONGeometry.TestPositionCreateJSONDataENotEnoughItemsOneItemD;
var
  jData: TJSONData;
  gotException: Boolean;
begin
  jData:= GetJSONData(cJSONPositionArrayOneItemD);
  gotException:= False;
  try
    try
      FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(jData);
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

procedure TTestGeoJSONGeometry.TestPositionCreateJSONDataTwoItemsI;
var
  jData: TJSONData;
begin
  jData:= GetJSONData(cJSONPositionArrayTwoItemsI);
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(jData);
  AssertEquals('Position Latitude is 100 I', 100, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is -100 I', -100, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 0 I', 0, FGeoJSONGeometryPosition.Altitude);
  AssertEquals('Position Has Altitude is False I', False, FGeoJSONGeometryPosition.HasAltitude);
  FGeoJSONGeometryPosition.Free;
  jData.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateJSONDataTwoItemsD;
var
  jData: TJSONData;
begin
  jData:= GetJSONData(cJSONPositionArrayTwoItemsD);
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(jData);
  AssertEquals('Position Latitude is 100.1 D', 100.1, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is -100.1 D', -100.1, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 0 D', 0.0, FGeoJSONGeometryPosition.Altitude);
  AssertEquals('Position Has Altitude is False D', False, FGeoJSONGeometryPosition.HasAltitude);
  FGeoJSONGeometryPosition.Free;
  jData.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateJSONDataThreeItemsI;
var
  jData: TJSONData;
begin
  jData:= GetJSONData(cJSONPositionArrayThreeItemsI);
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(jData);
  AssertEquals('Position Latitude is 100 I', 100, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is -100 I', -100, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 100 I', 100, FGeoJSONGeometryPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONGeometryPosition.HasAltitude);
  FGeoJSONGeometryPosition.Free;
  jData.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateJSONDataThreeItemsD;
var
  jData: TJSONData;
begin
  jData:= GetJSONData(cJSONPositionArrayThreeItemsD);
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(jData);
  AssertEquals('Position Latitude is 100.1 D', 100.1, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is -100.1 D', -100.1, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 100.1 D', 100.1, FGeoJSONGeometryPosition.Altitude);
  AssertEquals('Position Has Altitude is True D', True, FGeoJSONGeometryPosition.HasAltitude);
  FGeoJSONGeometryPosition.Free;
  jData.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateJSONDataFourItemsI;
var
  jData: TJSONData;
begin
  jData:= GetJSONData(cJSONPositionArrayFourItemsI);
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(jData);
  AssertEquals('Position Latitude is 100 I', 100, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is -100 I', -100, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 100 I', 100, FGeoJSONGeometryPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONGeometryPosition.HasAltitude);
  FGeoJSONGeometryPosition.Free;
  jData.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateJSONDataFourItemsD;
var
  jData: TJSONData;
begin
  jData:= GetJSONData(cJSONPositionArrayFourItemsD);
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(jData);
  AssertEquals('Position Latitude is 100.1 D', 100.1, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is -100.1 D', -100.1, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 100.1 D', 100.1, FGeoJSONGeometryPosition.Altitude);
  AssertEquals('Position Has Altitude is True D', True, FGeoJSONGeometryPosition.HasAltitude);
  FGeoJSONGeometryPosition.Free;
  jData.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateJSONWrongObject;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(cJSONEmptyObject);
    except
      on e: EWrongJSONObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONGeometryPosition.Free;
  end;
  AssertEquals('Got Exception EWrongJSONObject on empty object', True, gotException);
end;

procedure TTestGeoJSONGeometry.TestPositionCreateJSONENotEnoughItemsEmptyArray;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(cJSONEmptyArray);
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
end;

procedure TTestGeoJSONGeometry.TestPositionCreateJSONENotEnoughItemsOneItemI;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(cJSONPositionArrayOneItemI);
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
end;

procedure TTestGeoJSONGeometry.TestPositionCreateJSONENotEnoughItemsOneItemD;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(cJSONPositionArrayOneItemD);
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
end;

procedure TTestGeoJSONGeometry.TestPositionCreateJSONTwoItemsI;
begin
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(cJSONPositionArrayTwoItemsI);
  AssertEquals('Position Latitude is 100 I', 100, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is -100 I', -100, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 0 I', 0, FGeoJSONGeometryPosition.Altitude);
  AssertEquals('Position Has Altitude is False I', False, FGeoJSONGeometryPosition.HasAltitude);
  FGeoJSONGeometryPosition.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateJSONTwoItemsD;
begin
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(cJSONPositionArrayTwoItemsD);
  AssertEquals('Position Latitude is 100.1 D', 100.1, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is -100.1 D', -100.1, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 0.0 D', 0.0, FGeoJSONGeometryPosition.Altitude);
  AssertEquals('Position Has Altitude is False D', False, FGeoJSONGeometryPosition.HasAltitude);
  FGeoJSONGeometryPosition.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateJSONThreeItemsI;
begin
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(cJSONPositionArrayThreeItemsI);
  AssertEquals('Position Latitude is 100 I', 100, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is -100 I', -100, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 100 I', 100, FGeoJSONGeometryPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONGeometryPosition.HasAltitude);
  FGeoJSONGeometryPosition.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateJSONThreeItemsD;
begin
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(cJSONPositionArrayThreeItemsD);
  AssertEquals('Position Latitude is 100.1 D', 100.1, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is -100.1 D', -100.1, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 100.1 D', 100.1, FGeoJSONGeometryPosition.Altitude);
  AssertEquals('Position Has Altitude is True D', True, FGeoJSONGeometryPosition.HasAltitude);
  FGeoJSONGeometryPosition.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateJSONFourItemsI;
begin
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(cJSONPositionArrayFourItemsI);
  AssertEquals('Position Latitude is 100 I', 100, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is -100 I', -100, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 100 I', 100, FGeoJSONGeometryPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONGeometryPosition.HasAltitude);
  FGeoJSONGeometryPosition.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateJSONFourItemsD;
begin
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(cJSONPositionArrayFourItemsD);
  AssertEquals('Position Latitude is 100.1 D', 100.1, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is -100.1 D', -100.1, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 100.1 D', 100.1, FGeoJSONGeometryPosition.Altitude);
  AssertEquals('Position Has Altitude is True D', True, FGeoJSONGeometryPosition.HasAltitude);
  FGeoJSONGeometryPosition.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateStreamWrongObject;
var
  s: TStringStream;
  gotException: Boolean;
begin
  s:= TStringStream.Create(cJSONEmptyObject);
  gotException:= False;
  try
    try
      FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(s);
    except
      on e: EWrongJSONObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONGeometryPosition.Free;
  end;
  AssertEquals('Got Exception EWrongJSONObject on empty object', True, gotException);
  s.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateStreamENotEnoughItemsEmptyArray;
var
  s: TStringStream;
  gotException: Boolean;
begin
  s:= TStringStream.Create(cJSONEmptyArray);
  gotException:= False;
  try
    try
      FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(s);
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
  s.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateStreamENotEnoughItemsOneItemI;
var
  s: TStringStream;
  gotException: Boolean;
begin
  s:= TStringStream.Create(cJSONPositionArrayOneItemI);
  gotException:= False;
  try
    try
      FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(s);
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
  s.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateStreamENotEnoughItemsOneItemD;
var
  s: TStringStream;
  gotException: Boolean;
begin
  s:= TStringStream.Create(cJSONPositionArrayOneItemD);
  gotException:= False;
  try
    try
      FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(s);
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
  s.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateStreamTwoItemsI;
var
  s: TStringStream;
begin
  s:= TStringStream.Create(cJSONPositionArrayTwoItemsI);
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(s);
  AssertEquals('Position Latitude is 100 I', 100, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is -100 I', -100, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 0 I', 0, FGeoJSONGeometryPosition.Altitude);
  AssertEquals('Position Has Altitude is False I', False, FGeoJSONGeometryPosition.HasAltitude);
  FGeoJSONGeometryPosition.Free;
  s.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateStreamTwoItemsD;
var
  s: TStringStream;
begin
  s:= TStringStream.Create(cJSONPositionArrayTwoItemsD);
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(s);
  AssertEquals('Position Latitude is 100.1 I', 100.1, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is -100.1 I', -100.1, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 0.0 I', 0.0, FGeoJSONGeometryPosition.Altitude);
  AssertEquals('Position Has Altitude is False I', False, FGeoJSONGeometryPosition.HasAltitude);
  FGeoJSONGeometryPosition.Free;
  s.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateStreamThreeItemsI;
var
  s: TStringStream;
begin
  s:= TStringStream.Create(cJSONPositionArrayThreeItemsI);
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(s);
  AssertEquals('Position Latitude is 100 I', 100, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is -100 I', -100, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 100 I', 100, FGeoJSONGeometryPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONGeometryPosition.HasAltitude);
  FGeoJSONGeometryPosition.Free;
  s.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateStreamThreeItemsD;
var
  s: TStringStream;
begin
  s:= TStringStream.Create(cJSONPositionArrayThreeItemsD);
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(s);
  AssertEquals('Position Latitude is 100.1 I', 100.1, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is -100.1 I', -100.1, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 100.1 I', 100.1, FGeoJSONGeometryPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONGeometryPosition.HasAltitude);
  FGeoJSONGeometryPosition.Free;
  s.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateStreamFourItemsI;
var
  s: TStringStream;
begin
  s:= TStringStream.Create(cJSONPositionArrayFourItemsI);
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(s);
  AssertEquals('Position Latitude is 100 I', 100, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is -100 I', -100, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 100 I', 100, FGeoJSONGeometryPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONGeometryPosition.HasAltitude);
  FGeoJSONGeometryPosition.Free;
  s.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionCreateStreamFourItemsD;
var
  s: TStringStream;
begin
  s:= TStringStream.Create(cJSONPositionArrayFourItemsD);
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(s);
  AssertEquals('Position Latitude is 100.1 I', 100.1, FGeoJSONGeometryPosition.Latitude);
  AssertEquals('Position Longitude is -100.1 I', -100.1, FGeoJSONGeometryPosition.Longitude);
  AssertEquals('Position Altitude is 100.1 I', 100.1, FGeoJSONGeometryPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONGeometryPosition.HasAltitude);
  FGeoJSONGeometryPosition.Free;
  s.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionAsJSONI;
var
  s: TStringStream;
  stest: String;
begin
  s:= TStringStream.Create(cJSONPositionArrayTwoItemsI);
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(s);
  stest:= FGeoJSONGeometryPosition.asJSON;
  AssertEquals('Position asJSON I', cJSONPositionArrayTwoItemsI, stest);
  FGeoJSONGeometryPosition.Free;
  s.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionAsJSONAltitudeI;
var
  s: TStringStream;
  stest: String;
begin
  s:= TStringStream.Create(cJSONPositionArrayThreeItemsI);
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(s);
  stest:= FGeoJSONGeometryPosition.asJSON;
  AssertEquals('Position asJSON Altitude I', cJSONPositionArrayTwoItemsI, stest);
  FGeoJSONGeometryPosition.Free;
  s.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionAsJSOND;
var
  s: TStringStream;
  stest: String;
begin
  s:= TStringStream.Create(cJSONPositionArrayTwoItemsD);
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(s);
  stest:= FGeoJSONGeometryPosition.asJSON;
  AssertEquals('Position asJSON D', cJSONPositionArrayTwoItemsD, stest);
  FGeoJSONGeometryPosition.Free;
  s.Free;
end;

procedure TTestGeoJSONGeometry.TestPositionAsJSONAltitudeD;
var
  s: TStringStream;
  stest: String;
begin
  s:= TStringStream.Create(cJSONPositionArrayThreeItemsD);
  FGeoJSONGeometryPosition:= TGeoJSONGeometryPosition.Create(s);
  stest:= FGeoJSONGeometryPosition.asJSON;
  AssertEquals('Position asJSON Altitude D', cJSONPositionArrayTwoItemsD, stest);
  FGeoJSONGeometryPosition.Free;
  s.Free;
end;

initialization
  RegisterTest(TTestGeoJSONGeometry);
end.

