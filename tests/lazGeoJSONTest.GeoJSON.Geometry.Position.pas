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

    procedure TestPositionAltitude;

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

uses
  lazGeoJSONTest.Common;

{ TTestGeoJSONPosition }

procedure TTestGeoJSONPosition.TestPositionCreate;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create;
  AssertEquals('Position Latitude is 0.0', 0.0, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is 0.0', 0.0, FGeoJSONPosition.Longitude);
  AssertEquals('Position Has Altitude is False', False, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionAltitude;
var
  gotException: Boolean;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create;
  AssertEquals('Position Has Altitude is False', False, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Altitude:= 100.12;
  AssertEquals('Position Has Altitude is 100.12', 100.12, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.HasAltitude:= False;
  FGeoJSONPosition.HasAltitude:= True;
  AssertEquals('Position Has Altitude is 0.0', 0.0, FGeoJSONPosition.Altitude);
  FGeoJSONPosition.HasAltitude:= False;
  AssertEquals('Position Has Altitude is False', False, FGeoJSONPosition.HasAltitude);
  gotException:= False;
  try
    try
      FGeoJSONPosition.Altitude;
    except
      on e: EPositionNoAltitude do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONPosition.Free;
  end;
  AssertEquals('Got Exception EPositionNoAltitude on empty array', True, gotException);
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONArrayENotEnoughItemsEmptyArray;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONPosition:= TGeoJSONPosition.Create(TJSONArray(GetJSONData(cJSONEmptyArray)));
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

procedure TTestGeoJSONPosition.TestPositionCreateJSONArrayENotEnoughItemsOneItemI;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONPosition:= TGeoJSONPosition.Create(TJSONArray(GetJSONData(cJSONPositionArrayOneItemI)));
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

procedure TTestGeoJSONPosition.TestPositionCreateJSONArrayENotEnoughItemsOneItemD;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONPosition:= TGeoJSONPosition.Create(TJSONArray(GetJSONData(cJSONPositionArrayOneItemD)));
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

procedure TTestGeoJSONPosition.TestPositionCreateJSONArrayTwoItemsI;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(TJSONArray(GetJSONData(cJSONPositionArrayTwoItemsI)));
  AssertEquals('Position Latitude is '+IntToStr(cLatitudeI)+' I', cLatitudeI, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+IntToStr(cLongitudeI)+' I', cLongitudeI, FGeoJSONPosition.Longitude);
  AssertEquals('Position Has Altitude is False I', False, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONArrayTwoItemsD;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(TJSONArray(GetJSONData(cJSONPositionArrayTwoItemsD)));
  AssertEquals('Position Latitude is '+FloatToStr(cLatitudeD)+' D', cLatitudeD, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+FloatToStr(cLongitudeD)+' D', cLongitudeD, FGeoJSONPosition.Longitude);
  AssertEquals('Position Has Altitude is False D', False, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONArrayThreeItemsI;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(TJSONArray(GetJSONData(cJSONPositionArrayThreeItemsI)));
  AssertEquals('Position Latitude is '+IntToStr(cLatitudeI)+' I', cLatitudeI, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+IntToStr(cLongitudeI)+' I', cLongitudeI, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+IntToStr(cAltitudeI)+' I', cAltitudeI, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONArrayThreeItemsD;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(TJSONArray(GetJSONData(cJSONPositionArrayThreeItemsD)));
  AssertEquals('Position Latitude is '+FloatToStr(cLatitudeD)+' D', cLatitudeD, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+FloatToStr(cLongitudeD)+' D', cLongitudeD, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+FloatToStr(cAltitudeD)+' D', cAltitudeD, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True D', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONArrayFourItemsI;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(TJSONArray(GetJSONData(cJSONPositionArrayFourItemsI)));
  AssertEquals('Position Latitude is '+IntToStr(cLatitudeI)+' I', cLatitudeI, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+IntToStr(cLongitudeI)+' I', cLongitudeI, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+IntToStr(cAltitudeI)+' I', cAltitudeI, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONArrayFourItemsD;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(TJSONArray(GetJSONData(cJSONPositionArrayFourItemsD)));
  AssertEquals('Position Latitude is '+FloatToStr(cLatitudeD)+' D', cLatitudeD, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+FloatToStr(cLongitudeD)+' D', cLongitudeD, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+FloatToStr(cAltitudeD)+' D', cAltitudeD, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True D', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONDataWrongObject;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONPosition:= TGeoJSONPosition.Create(GetJSONData(cJSONEmptyObject));
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

procedure TTestGeoJSONPosition.TestPositionCreateJSONDataENotEnoughItemsEmptyArray;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONPosition:= TGeoJSONPosition.Create(GetJSONData(cJSONEmptyArray));
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

procedure TTestGeoJSONPosition.TestPositionCreateJSONDataENotEnoughItemsOneItemI;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONPosition:= TGeoJSONPosition.Create(GetJSONData(cJSONPositionArrayOneItemI));
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

procedure TTestGeoJSONPosition.TestPositionCreateJSONDataENotEnoughItemsOneItemD;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONPosition:= TGeoJSONPosition.Create(GetJSONData(cJSONPositionArrayOneItemD));
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

procedure TTestGeoJSONPosition.TestPositionCreateJSONDataTwoItemsI;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(GetJSONData(cJSONPositionArrayTwoItemsI));
  AssertEquals('Position Latitude is '+IntToStr(cLatitudeI)+' I', cLatitudeI, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+IntToStr(cLongitudeI)+' I', cLongitudeI, FGeoJSONPosition.Longitude);
  AssertEquals('Position Has Altitude is False I', False, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONDataTwoItemsD;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(GetJSONData(cJSONPositionArrayTwoItemsD));
  AssertEquals('Position Latitude is '+FloatToStr(cLatitudeD)+' D', cLatitudeD, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+FloatToStr(cLongitudeD)+' D', cLongitudeD, FGeoJSONPosition.Longitude);
  AssertEquals('Position Has Altitude is False D', False, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONDataThreeItemsI;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(GetJSONData(cJSONPositionArrayThreeItemsI));
  AssertEquals('Position Latitude is '+IntToStr(cLatitudeI)+' I', cLatitudeI, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+IntToStr(cLongitudeI)+' I', cLongitudeI, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+IntToStr(cAltitudeI)+' I', cAltitudeI, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONDataThreeItemsD;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(GetJSONData(cJSONPositionArrayThreeItemsD));
  AssertEquals('Position Latitude is '+FloatToStr(cLatitudeD)+' D', cLatitudeD, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+FloatToStr(cLongitudeD)+' D', cLongitudeD, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+FloatToStr(cAltitudeD)+' D', cAltitudeD, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True D', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONDataFourItemsI;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(GetJSONData(cJSONPositionArrayFourItemsI));
  AssertEquals('Position Latitude is '+IntToStr(cLatitudeI)+' I', cLatitudeI, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+IntToStr(cLongitudeI)+' I', cLongitudeI, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+IntToStr(cAltitudeI)+' I', cAltitudeI, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONDataFourItemsD;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(GetJSONData(cJSONPositionArrayFourItemsD));
  AssertEquals('Position Latitude is '+FloatToStr(cLatitudeD)+' D', cLatitudeD, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+FloatToStr(cLongitudeD)+' D', cLongitudeD, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+FloatToStr(cAltitudeD)+' D', cAltitudeD, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True D', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
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
  AssertEquals('Position Has Altitude is False I', False, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateJSONTwoItemsD;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(cJSONPositionArrayTwoItemsD);
  AssertEquals('Position Latitude is '+FloatToStr(cLatitudeD)+' D', cLatitudeD, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+FloatToStr(cLongitudeD)+' D', cLongitudeD, FGeoJSONPosition.Longitude);
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
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONPosition:= TGeoJSONPosition.Create(TStringStream.Create(cJSONEmptyObject));
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

procedure TTestGeoJSONPosition.TestPositionCreateStreamENotEnoughItemsEmptyArray;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONPosition:= TGeoJSONPosition.Create(TStringStream.Create(cJSONEmptyArray));
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

procedure TTestGeoJSONPosition.TestPositionCreateStreamENotEnoughItemsOneItemI;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONPosition:= TGeoJSONPosition.Create(TStringStream.Create(cJSONPositionArrayOneItemI));
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

procedure TTestGeoJSONPosition.TestPositionCreateStreamENotEnoughItemsOneItemD;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONPosition:= TGeoJSONPosition.Create(TStringStream.Create(cJSONPositionArrayOneItemD));
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

procedure TTestGeoJSONPosition.TestPositionCreateStreamTwoItemsI;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(TStringStream.Create(cJSONPositionArrayTwoItemsI));
  AssertEquals('Position Latitude is '+IntToStr(cLatitudeI)+' I', cLatitudeI, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+IntToStr(cLongitudeI)+' I', cLongitudeI, FGeoJSONPosition.Longitude);
  AssertEquals('Position Has Altitude is False I', False, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateStreamTwoItemsD;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(TStringStream.Create(cJSONPositionArrayTwoItemsD));
  AssertEquals('Position Latitude is '+FloatToStr(cLatitudeD)+' I', cLatitudeD, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+FloatToStr(cLongitudeD)+' I', cLongitudeD, FGeoJSONPosition.Longitude);
  AssertEquals('Position Has Altitude is False I', False, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateStreamThreeItemsI;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(TStringStream.Create(cJSONPositionArrayThreeItemsI));
  AssertEquals('Position Latitude is '+IntToStr(cLatitudeI)+' I', cLatitudeI, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+IntToStr(cLongitudeI)+' I', cLongitudeI, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+IntToStr(cAltitudeI)+' I', cAltitudeI, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateStreamThreeItemsD;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(TStringStream.Create(cJSONPositionArrayThreeItemsD));
  AssertEquals('Position Latitude is '+FloatToStr(cLatitudeD)+' I', cLatitudeD, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+FloatToStr(cLongitudeD)+' I', cLongitudeD, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+FloatToStr(cAltitudeD)+' I', cAltitudeD, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateStreamFourItemsI;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(TStringStream.Create(cJSONPositionArrayFourItemsI));
  AssertEquals('Position Latitude is '+IntToStr(cLatitudeI)+' I', cLatitudeI, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+IntToStr(cLongitudeI)+' I', cLongitudeI, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+IntToStr(cAltitudeI)+' I', cAltitudeI, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
end;

procedure TTestGeoJSONPosition.TestPositionCreateStreamFourItemsD;
begin
  FGeoJSONPosition:= TGeoJSONPosition.Create(TStringStream.Create(cJSONPositionArrayFourItemsD));
  AssertEquals('Position Latitude is '+FloatToStr(cLatitudeD)+' I', cLatitudeD, FGeoJSONPosition.Latitude);
  AssertEquals('Position Longitude is '+FloatToStr(cLongitudeD)+' I', cLongitudeD, FGeoJSONPosition.Longitude);
  AssertEquals('Position Altitude is '+FloatToStr(cAltitudeD)+' I', cAltitudeD, FGeoJSONPosition.Altitude);
  AssertEquals('Position Has Altitude is True I', True, FGeoJSONPosition.HasAltitude);
  FGeoJSONPosition.Free;
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

