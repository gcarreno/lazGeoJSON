{
  GeoJSON/Geometry/Position Object

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
unit lazGeoJSON.Geometry.Position;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpjson,
  lazGeoJSON.Utils;

type
{ Exceptions }
  // Position
  EPositionNoAltitude = class(Exception);
  EPositionWrongJSONObject = class(Exception);
  EPositionNotEnoughItems = class(Exception);

{ TGeoJSONPosition }
  TGeoJSONPosition = class(TObject)
  private
    FValues: Array of Double;
    FHasAltitude: Boolean;

    procedure DoLoadFromJSON(const aJSON: String);
    procedure DoLoadFromJSONData(const aJSONData: TJSONData);
    procedure DoLoadFromJSONArray(const aJSONArray: TJSONArray);
    procedure DoLoadFromStream(const AStream: TStream);

    function GetLatitude: Double;
    procedure SetLatitude(AValue: Double);

    function GetLongitude: Double;
    procedure SetLongitude(AValue: Double);

    function GetAltitude: Double;
    procedure SetAltitude(AValue: Double);

    procedure SetHasAltitude(AValue: Boolean);

    function GetJSON: String;
  protected
  public
    constructor Create;
    constructor Create(const aJSON: String);
    constructor Create(const aJSONData: TJSONData);
    constructor Create(const aJSONArray: TJSONArray);
    constructor Create(const aStream: TStream);
    destructor Destroy; override;

    property Longitude: Double
      read GetLongitude
      write SetLongitude;
    property Latitude: Double
      read GetLatitude
      write SetLatitude;
    property Altitude: Double
      read GetAltitude
      write SetAltitude;
    property HasAltitude: Boolean
      read FHasAltitude
      write SetHasAltitude;
    property asJSON: String
      read GetJSON;
  end;

implementation

{ TGeoJSONPosition }

procedure TGeoJSONPosition.DoLoadFromJSON(const aJSON: String);
var
  jData: TJSONData;
begin
  jData:= GetJSONData(aJSON);
  try
    DoLoadFromJSONData(jData);
  finally
    jData.Free;
  end;
end;

procedure TGeoJSONPosition.DoLoadFromJSONData(const aJSONData: TJSONData);
begin
  if aJSONData.JSONType <> jtArray then
    raise EPositionWrongJSONObject.Create('JSON Data does not contain an Array.');
  DoLoadFromJSONArray(aJSONData as TJSONArray);
end;

procedure TGeoJSONPosition.DoLoadFromJSONArray(const aJSONArray: TJSONArray);
begin
  if aJSONArray.Count < 2 then
    raise EPositionNotEnoughItems.CreateFmt('Not enough items (need 2 min): "%s".', [aJSONArray.AsJSON]);
  FValues[0]:= aJSONArray.Floats[0];
  FValues[1]:= aJSONArray.Floats[1];
  if aJSONArray.Count > 2 then
  begin
    if Length(FValues) < 3 then
      SetLength(FValues, 3);
    FValues[2]:= aJSONArray.Floats[2];
    FHasAltitude:= True;
  end;
end;

procedure TGeoJSONPosition.DoLoadFromStream(const AStream: TStream);
var
  jData: TJSONData;
begin
  jData:= GetJSONData(aStream);
  try
    DoLoadFromJSONData(jData);
  finally
    jData.Free;
  end;
end;

function TGeoJSONPosition.GetAltitude: Double;
begin
  if FHasAltitude then
  begin
    Result:= FValues[2];
  end
  else
    raise EPositionNoAltitude.Create('Object does not contain Altitude');
end;

function TGeoJSONPosition.GetJSON: String;
begin
  Result:= '[';
  Result+= FloatToStr(FValues[0]) + ', ';
  Result+= FloatToStr(FValues[1]);
  if FHasAltitude then
    Result+= ', '+FloatToStr(FValues[2]);
  Result+= ']';
end;

function TGeoJSONPosition.GetLatitude: Double;
begin
  Result:= FValues[0];
end;

function TGeoJSONPosition.GetLongitude: Double;
begin
  Result:= FValues[1];
end;

procedure TGeoJSONPosition.SetAltitude(AValue: Double);
begin
  if not FHasAltitude then
  begin
    SetLength(FValues, 3);
    FHasAltitude:= True;
  end;
  FValues[2]:= AValue;
end;

procedure TGeoJSONPosition.SetHasAltitude(AValue: Boolean);
begin
  if FHasAltitude = AValue then Exit;
  FHasAltitude:= AValue;
  case FHasAltitude of
    True:begin
      SetLength(FValues, 3);
      FValues[2]:= 0.0;
    end;
    False:begin
      SetLength(FValues, 2);
    end;
  end;
end;

procedure TGeoJSONPosition.SetLatitude(AValue: Double);
begin
  if FValues[0] = AValue then exit;
  FValues[0]:= AValue;
end;

procedure TGeoJSONPosition.SetLongitude(AValue: Double);
begin
  if FValues[1] = AValue then exit;
  FValues[1]:= AValue;
end;

constructor TGeoJSONPosition.Create;
begin
  SetLength(FValues, 2);
  FValues[0]:= 0.0;
  FValues[1]:= 0.0;
  FHasAltitude:= False;
end;

constructor TGeoJSONPosition.Create(const aJSON: String);
begin
  Create;
  DoLoadFromJSON(aJSON);
end;

constructor TGeoJSONPosition.Create(const aJSONData: TJSONData);
begin
  Create;
  DoLoadFromJSONData(AJSONData);
end;

constructor TGeoJSONPosition.Create(const aJSONArray: TJSONArray);
begin
  Create;
  DoLoadFromJSONArray(aJSONArray);
end;

constructor TGeoJSONPosition.Create(const aStream: TStream);
begin
  Create;
  DoLoadFromStream(aStream);
end;

destructor TGeoJSONPosition.Destroy;
begin
  SetLength(FValues, 0);
  inherited Destroy;
end;

end.
