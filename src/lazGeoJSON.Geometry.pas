{
  GeoJSON/Geometry Object

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
unit lazGeoJSON.Geometry;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils{, Contnrs}, fpjson,
  lazGeoJSON,
  lazGeoJSON.Utils;

type
{ Exceptions }
  EWrongJSONObject = class(Exception);
  ENotEnoughItems = class(Exception);

{ TGeoJSONGeometryPosition }
  TGeoJSONGeometryPosition = class(TObject)
  private
    FLongitude: Double;
    FLatitude: Double;
    FAltitude: Double;
    FHasAltitude: Boolean;

    procedure DoLoadFromJSON(const aJSON: String);
    procedure DoLoadFromJSONData(const aJSONData: TJSONData);
    procedure DoLoadFromJSONArray(const aJSONArray: TJSONArray);
    procedure DoLoadFromStream(const AStream: TStream);
    function GetJSON: String;
  protected
  public
    constructor Create;
    constructor Create(aJSON: String);
    constructor Create(aJSONData: TJSONData);
    constructor Create(aJSONArray: TJSONArray);
    constructor Create(aStream: TStream);

    property Longitude: Double
      read FLongitude
      write FLongitude;
    property Latitude: Double
      read FLatitude
      write FLatitude;
    property Altitude: Double
      read FAltitude
      write FAltitude;
    property HasAltitude: Boolean
      read FHasAltitude;
    property asJSON: String
      read GetJSON;
  end;

{ TGeoJSONGeometry }
  TGeoJSONGeometry = class (TGeoJSON)
  private
  protected
  public
  end;

implementation

{ TGeoJSONGeometryPosition }
procedure TGeoJSONGeometryPosition.DoLoadFromJSON(const aJSON: String);
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

procedure TGeoJSONGeometryPosition.DoLoadFromJSONData(const aJSONData: TJSONData);
begin
  if aJSONData.JSONType <> jtArray then
    raise EWrongJSONObject.Create('JSON Data does not contain an Array.');
  DoLoadFromJSONArray(aJSONData as TJSONArray);
end;

procedure TGeoJSONGeometryPosition.DoLoadFromJSONArray(const aJSONArray: TJSONArray);
begin
  if aJSONArray.Count < 2 then
    raise ENotEnoughItems.CreateFmt('Not enough items (need 2 min): "%s".', [aJSONArray.AsJSON]);
  FLatitude:= aJSONArray.Floats[0];
  FLongitude:= aJSONArray.Floats[1];
  if aJSONArray.Count > 2 then
  begin
    FAltitude:= aJSONArray.Floats[2];
    FHasAltitude:= True;
  end;
end;

procedure TGeoJSONGeometryPosition.DoLoadFromStream(const AStream: TStream);
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

function TGeoJSONGeometryPosition.GetJSON: String;
var
  jData: TJSONData;
begin
  if not FHasAltitude then
  begin
    jData:= TJSONArray.Create(
      [
        FLongitude,
        FLatitude
      ]
    );
  end
  else
  begin
    jData:= TJSONArray.Create(
      [
        FLongitude,
        FLatitude,
        FAltitude
      ]
    );
  end;
  Result:= jData.AsJSON;
end;

constructor TGeoJSONGeometryPosition.Create;
begin
  FLongitude:= 0.0;
  FLatitude:= 0.0;
  FAltitude:= 0.0;
  FHasAltitude:= False;
end;

constructor TGeoJSONGeometryPosition.Create(aJSON: String);
begin
  Create;
  DoLoadFromJSON(aJSON);
end;

constructor TGeoJSONGeometryPosition.Create(aJSONData: TJSONData);
begin
  Create;
  DoLoadFromJSONData(AJSONData);
end;

constructor TGeoJSONGeometryPosition.Create(aJSONArray: TJSONArray);
begin
  Create;
  DoLoadFromJSONArray(aJSONArray);
end;

constructor TGeoJSONGeometryPosition.Create(aStream: TStream);
begin
  Create;
  DoLoadFromStream(aStream);
end;

end.

