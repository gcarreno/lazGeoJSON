{
  GeoJSON/Geometry/Point

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
unit lazGeoJSON.Geometry.Point;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpjson,
  lazGeoJSON,
  lazGeoJSON.Utils,
  lazGeoJSON.Geometry.Position;

type
{ Exceptions }
  // Point
  EPointWrongObject = class(Exception);
  EPointWrongFormedObject = class(Exception);

{ TGeoJSONPoint }
  TGeoJSONPoint = class(TGeoJSON)
  private
    FCoordinates: TGeoJSONPosition;

    procedure DoLoadFromJSON(const aJSON: String);
    procedure DoLoadFromJSONData(const aJSONData: TJSONData);
    procedure DoLoadFromJSONObject(const aJSONObject: TJSONObject);
    procedure DoLoadFromStream(const aStream: TStream);
    function GetJSON: String;
  protected
  public
    constructor Create;
    constructor Create(const aJSON: String);
    constructor Create(const aJSONData: TJSONData);
    constructor Create(const aJSONObject: TJSONObject);
    constructor Create(const aStream: TStream);
    destructor Destroy; override;

    property Coordinates: TGeoJSONPosition
      read FCoordinates;
    property asJSON: String
      read GetJSON;
  end;


implementation

{ TGeoJSONPoint }
procedure TGeoJSONPoint.DoLoadFromJSON(const aJSON: String);
var
  jData: TJSONData;
begin
  jData:= GetJSONData(aJSON);
  try
    DoLoadFromJSONData(jData)
  finally
    jData.Free;
  end;
end;

procedure TGeoJSONPoint.DoLoadFromJSONData(const aJSONData: TJSONData);
begin
  if aJSONData.JSONType <> jtObject then
    raise EPointWrongObject.Create('JSON Data does not contain an Object.');
  DoLoadFromJSONObject(aJSONData as TJSONObject);
end;

procedure TGeoJSONPoint.DoLoadFromJSONObject(const aJSONObject: TJSONObject);
begin
  if aJSONObject.IndexOfName('type') = -1 then
    raise EPointWrongFormedObject.Create('Object does not contain member type.');
  if aJSONObject.Strings['type'] <> 'Point' then
    raise EPointWrongFormedObject.Create('Member type is not Point.');
  if aJSONObject.IndexOfName('coordinates') = -1 then
    raise EPointWrongFormedObject.Create('Object does not contain member coordinates.');
  FCoordinates:= TGeoJSONPosition.Create(aJSONObject.Arrays['coordinates']);
end;

procedure TGeoJSONPoint.DoLoadFromStream(const aStream: TStream);
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

function TGeoJSONPoint.GetJSON: String;
begin
  Result:= '{"type": "Point", "coordinates": ';
  Result+= FCoordinates.asJSON;
  Result+= '}';
end;

constructor TGeoJSONPoint.Create;
begin
  FGJType:= gjtPoint;
  FCoordinates:= TGeoJSONPosition.Create;
end;

constructor TGeoJSONPoint.Create(const aJSON: String);
begin
  FGJType:= gjtPoint;
  DoLoadFromJSON(aJSON);
end;

constructor TGeoJSONPoint.Create(const aJSONData: TJSONData);
begin
  FGJType:= gjtPoint;
  DoLoadFromJSONData(aJSONData);
end;

constructor TGeoJSONPoint.Create(const aJSONObject: TJSONObject);
begin
  FGJType:= gjtPoint;
  DoLoadFromJSONObject(aJSONObject);
end;

constructor TGeoJSONPoint.Create(const aStream: TStream);
begin
  FGJType:= gjtPoint;
  DoLoadFromStream(aStream);
end;

destructor TGeoJSONPoint.Destroy;
begin
  if Assigned(FCoordinates) then
    FCoordinates.Free;
  inherited Destroy;
end;

end.

