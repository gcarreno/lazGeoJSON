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
unit lazGeoJSONTest.GeoJSON.Geometry.Position;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, {testutils,} testregistry, fpjson,
  lazGeoJSON.Utils,
  lazGeoJSON.Geometry.Position;

type
{ TTestGeoJSONPosition }
  TTestGeoJSONPosition = class(TTestCase)
  private
    FGeoJSONPosition: TGeoJSONPosition;
  protected
  public
  published
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
  cJSONEmptyArray =             '[]';

// Float and Integer Constants
  cLatitudeI = 100;
  cLongitudeI = -100;
  cAltitudeI = 100;
  cLatitudeD = 100.12;
  cLongitudeD = -100.12;
  cAltitudeD = 100.12;

// TGeoJSONPosition
  cJSONPositionArrayOneItemI =    '[100]';
  cJSONPositionArrayTwoItemsI =   '[100, -100]';
  cJSONPositionArrayThreeItemsI = '[100, -100, 100]';
  cJSONPositionArrayFourItemsI =  '[100, -100, 100, 100]';
  cJSONPositionArrayOneItemD =    '[100.12]';
  cJSONPositionArrayTwoItemsD =   '[100.12, -100.12]';
  cJSONPositionArrayThreeItemsD = '[100.12, -100.12, 100.12]';
  cJSONPositionArrayFourItemsD =  '[100.12, -100.12, 100.12, 100.12]';

{ TTestGeoJSONPosition }

procedure TTestGeoJSONPosition.TestPositionCreate;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create;
  AssertEquals('Position Latitude is 0.0', 0.0, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is 0.0', 0.0, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is 0.0', 0.0, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is False', False, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONArrayENotEnoughItemsEmptyArray;
var
  jData: TJSONData;
  gotException: Boolean;
begin
  jData:= GetJSONData(cJSONEmptyArray);
  gotException:= False;
  try
    try
      FGeoJSONPosition:= TGeoJSONPosition.Create(TJSONArray(jData));
    except
      on e: EPositionNotEnoughItems do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPosition.Free;
  end;
  jData.Free;
  AssertEquals('Got Exception EPositionNotEnoughItems on empty array', True, gotException);
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONArrayENotEnoughItemsOneItemI;
var
  jData: TJSONData;
  gotException: Boolean;
begin
  jData:= GetJSONData(cJSONPositionArrayOneItemI);
  gotException:= False;
  try
    try
      FGeoJSONPosition:= TGeoJSONPosition.Create(TJSONArray(jData));
    except
      on e: EPositionNotEnoughItems do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPosition.Free;
  end;
  AssertEquals('Got Exception EPositionNotEnoughItems on one item I', True, gotException);
  jData.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONArrayENotEnoughItemsOneItemD;
var
  jData: TJSONData;
  gotException: Boolean;
begin
  jData:= GetJSONData(cJSONPositionArrayOneItemD);
  gotException:= False;
  try
    try
      FGeoJSONPosition:= TGeoJSONPosition.Create(TJSONArray(jData));
    except
      on e: EPositionNotEnoughItems do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPosition.Free;
  end;
  AssertEquals('Got Exception EPositionNotEnoughItems on one item D', True, gotException);
  jData.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONArrayTwoItemsI;
var
  jData: TJSONData;
begin
  jData:= GetJSONData(cJSONPositionArrayTwoItemsI);
  FGeoJSONPosition:= TGeoJSONPosition.Create(TJSONArray(jData));
  AssertEquals('Position Latitude is '+IntToStr(cLatitudeI)+' I', cLatitudeI, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+IntToStr(cLongitudeI)+' I', cLongitudeI, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is 0 I', 0, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is False I', False, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
  jData.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONArrayTwoItemsD;
var
  jData: TJSONData;
begin
  jData:= GetJSONData(cJSONPositionArrayTwoItemsD);
  FGeoJSONPosition:= TGeoJSONPosition.Create(TJSONArray(jData));
  AssertEquals('Position Latitude is '+FloatToStr(cLatitudeD)+' D', cLatitudeD, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+FloatToStr(cLongitudeD)+' D', cLongitudeD, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is 0.0 D', 0.0, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is False D', False, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
  jData.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONArrayThreeItemsI;
var
  jData: TJSONData;
begin
  jData:= GetJSONData(cJSONPositionArrayThreeItemsI);
  FGeoJSONPosition:= TGeoJSONPosition.Create(TJSONArray(jData));
  AssertEquals('Position Latitude is '+IntToStr(cLatitudeI)+' I', cLatitudeI, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+IntToStr(cLongitudeI)+' I', cLongitudeI, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+IntToStr(cAltitudeI)+' I', cAltitudeI, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
  jData.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONArrayThreeItemsD;
var
  jData: TJSONData;
begin
  jData:= GetJSONData(cJSONPositionArrayThreeItemsD);
  FGeoJSONPosition:= TGeoJSONPosition.Create(TJSONArray(jData));
  AssertEquals('Position Latitude is '+FloatToStr(cLatitudeD)+' D', cLatitudeD, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+FloatToStr(cLongitudeD)+' D', cLongitudeD, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+FloatToStr(cAltitudeD)+' D', cAltitudeD, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True D', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
  jData.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONArrayFourItemsI;
var
  jData: TJSONData;
begin
  jData:= GetJSONData(cJSONPositionArrayFourItemsI);
  FGeoJSONPosition:= TGeoJSONPosition.Create(TJSONArray(jData));
  AssertEquals('Position Latitude is '+IntToStr(cLatitudeI)+' I', cLatitudeI, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+IntToStr(cLongitudeI)+' I', cLongitudeI, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+IntToStr(cAltitudeI)+' I', cAltitudeI, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
  jData.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONArrayFourItemsD;
var
  jData: TJSONData;
begin
  jData:= GetJSONData(cJSONPositionArrayFourItemsD);
  FGeoJSONPosition:= TGeoJSONPosition.Create(TJSONArray(jData));
  AssertEquals('Position Latitude is '+FloatToStr(cLatitudeD)+' D', cLatitudeD, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+FloatToStr(cLongitudeD)+' D', cLongitudeD, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+FloatToStr(cAltitudeD)+' D', cAltitudeD, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True D', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
  jData.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONDataWrongObject;
var
  jData: TJSONData;
  gotException: Boolean;
begin
  jData:= GetJSONData(cJSONEmptyObject);
  gotException:= False;
  try
    try
      FGeoJSONPosition:= TGeoJSONPosition.Create(jData);
    except
      on e: EPositionWrongJSONObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPosition.Free;
  end;
  AssertEquals('Got Exception EPositionWrongJSONObject on empty object', True, gotException);
  jData.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONDataENotEnoughItemsEmptyArray;
var
  jData: TJSONData;
  gotException: Boolean;
begin
  jData:= GetJSONData(cJSONEmptyArray);
  gotException:= False;
  try
    try
      FGeoJSONPosition:= TGeoJSONPosition.Create(jData);
    except
      on e: EPositionNotEnoughItems do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPosition.Free;
  end;
  AssertEquals('Got Exception EPositionNotEnoughItems on empty array', True, gotException);
  jData.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONDataENotEnoughItemsOneItemI;
var
  jData: TJSONData;
  gotException: Boolean;
begin
  jData:= GetJSONData(cJSONPositionArrayOneItemI);
  gotException:= False;
  try
    try
      FGeoJSONPosition:= TGeoJSONPosition.Create(jData);
    except
      on e: EPositionNotEnoughItems do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPosition.Free;
  end;
  AssertEquals('Got Exception EPositionNotEnoughItems on one item I', True, gotException);
  jData.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONDataENotEnoughItemsOneItemD;
var
  jData: TJSONData;
  gotException: Boolean;
begin
  jData:= GetJSONData(cJSONPositionArrayOneItemD);
  gotException:= False;
  try
    try
      FGeoJSONPosition:= TGeoJSONPosition.Create(jData);
    except
      on e: EPositionNotEnoughItems do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPosition.Free;
  end;
  AssertEquals('Got Exception EPositionNotEnoughItems on one item D', True, gotException);
  jData.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONDataTwoItemsI;
var
  jData: TJSONData;
begin
  jData:= GetJSONData(cJSONPositionArrayTwoItemsI);
  FGeoJSONPosition:= TGeoJSONPosition.Create(jData);
  AssertEquals('Position Latitude is '+IntToStr(cLatitudeI)+' I', cLatitudeI, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+IntToStr(cLongitudeI)+' I', cLongitudeI, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is 0 I', 0, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is False I', False, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
  jData.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONDataTwoItemsD;
var
  jData: TJSONData;
begin
  jData:= GetJSONData(cJSONPositionArrayTwoItemsD);
  FGeoJSONPosition:= TGeoJSONPosition.Create(jData);
  AssertEquals('Position Latitude is '+FloatToStr(cLatitudeD)+' D', cLatitudeD, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+FloatToStr(cLongitudeD)+' D', cLongitudeD, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is 0.0 D', 0.0, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is False D', False, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
  jData.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONDataThreeItemsI;
var
  jData: TJSONData;
begin
  jData:= GetJSONData(cJSONPositionArrayThreeItemsI);
  FGeoJSONPosition:= TGeoJSONPosition.Create(jData);
  AssertEquals('Position Latitude is '+IntToStr(cLatitudeI)+' I', cLatitudeI, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+IntToStr(cLongitudeI)+' I', cLongitudeI, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+IntToStr(cAltitudeI)+' I', cAltitudeI, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
  jData.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONDataThreeItemsD;
var
  jData: TJSONData;
begin
  jData:= GetJSONData(cJSONPositionArrayThreeItemsD);
  FGeoJSONPosition:= TGeoJSONPosition.Create(jData);
  AssertEquals('Position Latitude is '+FloatToStr(cLatitudeD)+' D', cLatitudeD, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+FloatToStr(cLongitudeD)+' D', cLongitudeD, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+FloatToStr(cAltitudeD)+' D', cAltitudeD, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True D', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
  jData.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONDataFourItemsI;
var
  jData: TJSONData;
begin
  jData:= GetJSONData(cJSONPositionArrayFourItemsI);
  FGeoJSONPosition:= TGeoJSONPosition.Create(jData);
  AssertEquals('Position Latitude is '+IntToStr(cLatitudeI)+' I', cLatitudeI, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+IntToStr(cLongitudeI)+' I', cLongitudeI, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+IntToStr(cAltitudeI)+' I', cAltitudeI, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
  jData.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONDataFourItemsD;
var
  jData: TJSONData;
begin
  jData:= GetJSONData(cJSONPositionArrayFourItemsD);
  FGeoJSONPosition:= TGeoJSONPosition.Create(jData);
  AssertEquals('Position Latitude is '+FloatToStr(cLatitudeD)+' D', cLatitudeD, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+FloatToStr(cLongitudeD)+' D', cLongitudeD, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+FloatToStr(cAltitudeD)+' D', cAltitudeD, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True D', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
  jData.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONWrongObject;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONPosition:= TGeoJSONPosition.Create(cJSONEmptyObject);
    except
      on e: EPositionWrongJSONObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPosition.Free;
  end;
  AssertEquals('Got Exception EPositionWrongJSONObject on empty object', True, gotException);
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONENotEnoughItemsEmptyArray;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONPosition:= TGeoJSONPosition.Create(cJSONEmptyArray);
    except
      on e: EPositionNotEnoughItems do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPosition.Free;
  end;
  AssertEquals('Got Exception EPositionNotEnoughItems on empty array', True, gotException);
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONENotEnoughItemsOneItemI;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONPosition:= TGeoJSONPosition.Create(cJSONPositionArrayOneItemI);
    except
      on e: EPositionNotEnoughItems do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPosition.Free;
  end;
  AssertEquals('Got Exception EPositionNotEnoughItems on one item I', True, gotException);
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONENotEnoughItemsOneItemD;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONPosition:= TGeoJSONPosition.Create(cJSONPositionArrayOneItemD);
    except
      on e: EPositionNotEnoughItems do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPosition.Free;
  end;
  AssertEquals('Got Exception EPositionNotEnoughItems on one item D', True, gotException);
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONTwoItemsI;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(cJSONPositionArrayTwoItemsI);
  AssertEquals('Position Latitude is '+IntToStr(cLatitudeI)+' I', cLatitudeI, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+IntToStr(cLongitudeI)+' I', cLongitudeI, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is 0 I', 0, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is False I', False, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONTwoItemsD;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(cJSONPositionArrayTwoItemsD);
  AssertEquals('Position Latitude is '+FloatToStr(cLatitudeD)+' D', cLatitudeD, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+FloatToStr(cLongitudeD)+' D', cLongitudeD, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is 0.0 D', 0.0, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is False D', False, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONThreeItemsI;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(cJSONPositionArrayThreeItemsI);
  AssertEquals('Position Latitude is '+IntToStr(cLatitudeI)+' I', cLatitudeI, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+IntToStr(cLongitudeI)+' I', cLongitudeI, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+IntToStr(cAltitudeI)+' I', cAltitudeI, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONThreeItemsD;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(cJSONPositionArrayThreeItemsD);
  AssertEquals('Position Latitude is '+FloatToStr(cLatitudeD)+' D', cLatitudeD, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+FloatToStr(cLongitudeD)+' D', cLongitudeD, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+FloatToStr(cAltitudeD)+' D', cAltitudeD, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True D', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONFourItemsI;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(cJSONPositionArrayFourItemsI);
  AssertEquals('Position Latitude is '+IntToStr(cLatitudeI)+' I', cLatitudeI, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+IntToStr(cLongitudeI)+' I', cLongitudeI, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+IntToStr(cAltitudeI)+' I', cAltitudeI, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONFourItemsD;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(cJSONPositionArrayFourItemsD);
  AssertEquals('Position Latitude is '+FloatToStr(cLatitudeD)+' D', cLatitudeD, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+FloatToStr(cLongitudeD)+' D', cLongitudeD, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+FloatToStr(cAltitudeD)+' D', cAltitudeD, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True D', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateStreamWrongObject;
var
  s: TStringStream;
  gotException: Boolean;
begin
  s:= TStringStream.Create(cJSONEmptyObject);
  gotException:= False;
  try
    try
      FGeoJSONPosition:= TGeoJSONPosition.Create(s);
    except
      on e: EPositionWrongJSONObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPosition.Free;
  end;
  AssertEquals('Got Exception EPositionWrongJSONObject on empty object', True, gotException);
  s.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateStreamENotEnoughItemsEmptyArray;
var
  s: TStringStream;
  gotException: Boolean;
begin
  s:= TStringStream.Create(cJSONEmptyArray);
  gotException:= False;
  try
    try
      FGeoJSONPosition:= TGeoJSONPosition.Create(s);
    except
      on e: EPositionNotEnoughItems do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPosition.Free;
  end;
  AssertEquals('Got Exception EPositionNotEnoughItems on empty array', True, gotException);
  s.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateStreamENotEnoughItemsOneItemI;
var
  s: TStringStream;
  gotException: Boolean;
begin
  s:= TStringStream.Create(cJSONPositionArrayOneItemI);
  gotException:= False;
  try
    try
      FGeoJSONPosition:= TGeoJSONPosition.Create(s);
    except
      on e: EPositionNotEnoughItems do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPosition.Free;
  end;
  AssertEquals('Got Exception EPositionNotEnoughItems on one item I', True, gotException);
  s.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateStreamENotEnoughItemsOneItemD;
var
  s: TStringStream;
  gotException: Boolean;
begin
  s:= TStringStream.Create(cJSONPositionArrayOneItemD);
  gotException:= False;
  try
    try
      FGeoJSONPosition:= TGeoJSONPosition.Create(s);
    except
      on e: EPositionNotEnoughItems do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPosition.Free;
  end;
  AssertEquals('Got Exception EPositionNotEnoughItems on one item D', True, gotException);
  s.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateStreamTwoItemsI;
var
  s: TStringStream;
begin
  s:= TStringStream.Create(cJSONPositionArrayTwoItemsI);
  FGeoJSONPosition:= TGeoJSONPosition.Create(s);
  AssertEquals('Position Latitude is '+IntToStr(cLatitudeI)+' I', cLatitudeI, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+IntToStr(cLongitudeI)+' I', cLongitudeI, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is 0 I', 0, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is False I', False, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
  s.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateStreamTwoItemsD;
var
  s: TStringStream;
begin
  s:= TStringStream.Create(cJSONPositionArrayTwoItemsD);
  FGeoJSONPosition:= TGeoJSONPosition.Create(s);
  AssertEquals('Position Latitude is '+FloatToStr(cLatitudeD)+' I', cLatitudeD, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+FloatToStr(cLongitudeD)+' I', cLongitudeD, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is 0.0 I', 0.0, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is False I', False, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
  s.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateStreamThreeItemsI;
var
  s: TStringStream;
begin
  s:= TStringStream.Create(cJSONPositionArrayThreeItemsI);
  FGeoJSONPosition:= TGeoJSONPosition.Create(s);
  AssertEquals('Position Latitude is '+IntToStr(cLatitudeI)+' I', cLatitudeI, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+IntToStr(cLongitudeI)+' I', cLongitudeI, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+IntToStr(cAltitudeI)+' I', cAltitudeI, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
  s.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateStreamThreeItemsD;
var
  s: TStringStream;
begin
  s:= TStringStream.Create(cJSONPositionArrayThreeItemsD);
  FGeoJSONPosition:= TGeoJSONPosition.Create(s);
  AssertEquals('Position Latitude is '+FloatToStr(cLatitudeD)+' I', cLatitudeD, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+FloatToStr(cLongitudeD)+' I', cLongitudeD, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+FloatToStr(cAltitudeD)+' I', cAltitudeD, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
  s.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateStreamFourItemsI;
var
  s: TStringStream;
begin
  s:= TStringStream.Create(cJSONPositionArrayFourItemsI);
  FGeoJSONPosition:= TGeoJSONPosition.Create(s);
  AssertEquals('Position Latitude is '+IntToStr(cLatitudeI)+' I', cLatitudeI, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+IntToStr(cLongitudeI)+' I', cLongitudeI, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+IntToStr(cAltitudeI)+' I', cAltitudeI, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
  s.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateStreamFourItemsD;
var
  s: TStringStream;
begin
  s:= TStringStream.Create(cJSONPositionArrayFourItemsD);
  FGeoJSONPosition:= TGeoJSONPosition.Create(s);
  AssertEquals('Position Latitude is '+FloatToStr(cLatitudeD)+' I', cLatitudeD, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+FloatToStr(cLongitudeD)+' I', cLongitudeD, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+FloatToStr(cAltitudeD)+' I', cAltitudeD, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
  s.Free;
end;

procedure TTestGeoJSONPosition.TestPositionAsJSONI;
var
  s: String;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(cJSONPositionArrayTwoItemsI);
  s:= FGeoJSONPosition.asJSON;
  AssertEquals('Position asJSON I', cJSONPositionArrayTwoItemsI, s);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionAsJSONAltitudeI;
var
  s: String;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(cJSONPositionArrayThreeItemsI);
  s:= FGeoJSONPosition.asJSON;
  AssertEquals('Position asJSON Altitude I', cJSONPositionArrayThreeItemsI, s);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionAsJSOND;
var
  s: String;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(cJSONPositionArrayTwoItemsD);
  s:= FGeoJSONPosition.asJSON;
  AssertEquals('Position asJSON D', cJSONPositionArrayTwoItemsD, s);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionAsJSONAltitudeD;
var
  s: String;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(cJSONPositionArrayThreeItemsD);
  s:= FGeoJSONPosition.asJSON;
  AssertEquals('Position asJSON Altitude D', cJSONPositionArrayThreeItemsD, s);
  FGeoJSONPosition.Free;
end;

initialization
  RegisterTest(TTestGeoJSONPosition);
end.

