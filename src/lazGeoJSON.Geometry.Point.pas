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
  lazGeoJSON.Geometry.Position;

type
{ Exceptions }
  // Point
  EPointWrongObject = class(Exception);
  EpointWrongFormedObject = class(Exception);

{ TGeoJSONPoint }
  TGeoJSONPoint = class(TGeoJSON)
  private
    FPosition: TGeoJSONPosition;

    procedure DoLoadFromJSON(const aJSON: String);
    procedure DoLoadFromJSONData(const aJSONData: TJSONData);
    procedure DoLoadFromJSONObject(const aJSONObject: TJSONObject);
  protected
  public
    constructor Create;
    constructor Create(const aJSON: String);
    constructor Create(const aJSONData: TJSONData);
    constructor Create(const aJSONObject: TJSONObject);
    destructor Destroy; override;

    property Position: TGeoJSONPosition
      read FPosition;
  end;


implementation

{ TGeoJSONPoint }
procedure TGeoJSONPoint.DoLoadFromJSON(const aJSON: String);
var
  jData: TJSONData;
begin
  jData:= GetJSON(aJSON);
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
end;

procedure TGeoJSONPoint.DoLoadFromJSONObject(const aJSONObject: TJSONObject);
begin
  //
end;

constructor TGeoJSONPoint.Create;
begin
  FGJType:= gjtPoint;
  FPosition:= TGeoJSONPosition.Create;
end;

constructor TGeoJSONPoint.Create(const aJSON: String);
begin
  Create;
  DoLoadFromJSON(aJSON);
end;

constructor TGeoJSONPoint.Create(const aJSONData: TJSONData);
begin
  Create;
  DoLoadFromJSONData(aJSONData);
end;

constructor TGeoJSONPoint.Create(const aJSONObject: TJSONObject);
begin
  Create;
  DoLoadFromJSONObject(aJSONObject);
end;

destructor TGeoJSONPoint.Destroy;
begin
  inherited Destroy;
  if Assigned(FPosition) then
    FPosition.Free;
end;

end.

