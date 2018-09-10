{
  GeoJSON/Feature Object

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
unit lazGeoJSON.Feature;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpjson,
  lazGeoJSON,
  lazGeoJSON.Utils,
  lazGeoJSON.Geometry.Point;

type
{ Exceptions }
  EFeatureWrongObject = class(Exception);
  EFeatureWrongFormedObject = class(Exception);

{ TGeoJSONFeature }
  TGeoJSONFeature = class(TGeoJSON)
  private
    FID: String;
    FGeometry: TGeoJSON;
    FProperties: TJSONData;
    FHasProperties: Boolean;

    procedure DoLoadFromJSON(const aJSON: String);
    procedure DoLoadFromJSONData(const aJSONData: TJSONData);
    procedure DoLoadFromJSONObject(const aJSONObject: TJSONObject);
    procedure DoLoadFromStream(const aStream: TStream);
    function GetHasID: Boolean;
    function GetJSON: String;
  protected
  public
    constructor Create;
    constructor Create(const aJSON: String);
    constructor Create(const aJSONData: TJSONData);
    constructor Create(const aJSONObject: TJSONObject);
    constructor Create(const aStream: TStream);
    destructor Destroy; override;

    property ID: String
      read FID
      write FID;
    property HasID: Boolean
      read GetHasID;
    property Geometry: TGeoJSON
      read FGeometry;
    property Properties: TJSONData
      read FProperties;
    property HasProperties: Boolean
      read FHasProperties;
    property asJSON: String
      read GetJSON;
  end;

implementation

{ TGeoJSONFeature }

procedure TGeoJSONFeature.DoLoadFromJSON(const aJSON: String);
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

procedure TGeoJSONFeature.DoLoadFromJSONData(const aJSONData: TJSONData);
begin
  if aJSONData.JSONType <> jtObject then
    raise EFeatureWrongObject.Create('JSONData does not contain an Object.');
  DoLoadFromJSONObject(aJSONData as TJSONObject);
end;

procedure TGeoJSONFeature.DoLoadFromJSONObject(const aJSONObject: TJSONObject);
begin
  if aJSONObject.IndexOfName('type') = -1 then
    raise EFeatureWrongFormedObject.Create('Object does not contain member type');
  if aJSONObject.Strings['type'] <> 'Feature' then
    raise EFeatureWrongFormedObject.Create('Member type is not Feature');
  if aJSONObject.IndexOfName('geometry') = -1 then
    raise EFeatureWrongFormedObject.Create('Object does not contain member geometry');
  if aJSONObject.IndexOfName('id') <> -1 then
  begin
    FID:= aJSONObject.Strings['id'];
  end;
  { Go through all the Geometries }
  { TODO -ogcarreno -cGeoJSON.Feature : Need a safer way to test for the Geometry type }
  if aJSONObject.Objects['geometry'].Strings['type'] = 'Point' then
    FGeometry:= TGeoJSONPoint.Create(aJSONObject.Objects['geometry']);
  //if aJSONObject.Objects['geometry'].Strings['type'] = 'MultiPoint' then
  //  FGeometry:= TGeoJSONMultiPoint.Create(aJSONObject.Objects['geometry']);
  { END Goemetries }
  if aJSONObject.IndexOfName('properties') <> -1 then
  begin
    if aJSONObject.Items[aJSONObject.IndexOfName('properties')].JSONType = jtObject then
    begin
      FProperties:= aJSONObject.Items[aJSONObject.IndexOfName('properties')].Clone;
      FHasProperties:= True;
    end;
  end;
end;

procedure TGeoJSONFeature.DoLoadFromStream(const aStream: TStream);
var
  jData: TJSONData;
begin
  jData:= GetJSONData(aStream);
  DoLoadFromJSONData(jData);
  jData.Free;
end;

function TGeoJSONFeature.GetHasID: Boolean;
begin
  Result:= FID <> '';
end;

function TGeoJSONFeature.GetJSON: String;
var
  jFeature: TJSONObject;
begin
  Result:= '';
  jFeature:= TJSONObject.Create;
  try
    jFeature.Add('type', TJSONString.Create('Feature'));
    if GetHasID then
      jFeature.Add('id', TJSONString.Create(FID));
    if Assigned(FGeometry) then
    begin
      case FGeometry.GeoJSONType of
        gjtPoint: begin
          jFeature.Add('geometry', GetJSONData(TGeoJSONPoint(FGeometry).asJSON).Clone);
        end;
        //gjtMultiPoint: begin
        //  Result+= ', "geometry": ' + TGeoJSONMultiPoint(FGeometry).asJSON;
        //end;
      end;
    end;
    if Assigned(FProperties) then
      jFeature.Add('properties', FProperties.Clone);
    Result:= jFeature.FormatJSON(AsCompressedJSON);
  finally
    jFeature.Free;
  end;
end;

constructor TGeoJSONFeature.Create;
begin
  FGeoJSONType:= gjtFeature;
  FID:= '';
  FGeometry:= nil;
  FProperties:= nil;
  FHasProperties:= False;
end;

constructor TGeoJSONFeature.Create(const aJSON: String);
begin
  Create;
  DoLoadFromJSON(aJSON);
end;

constructor TGeoJSONFeature.Create(const aJSONData: TJSONData);
begin
  Create;
  DoLoadFromJSONData(aJSONData);
end;

constructor TGeoJSONFeature.Create(const aJSONObject: TJSONObject);
begin
  Create;
  DoLoadFromJSONObject(aJSONObject);
end;

constructor TGeoJSONFeature.Create(const aStream: TStream);
begin
  Create;
  DoLoadFromStream(aStream);
end;

destructor TGeoJSONFeature.Destroy;
begin
  if Assigned(FGeometry) then
    case FGeometry.GeoJSONType of
      gjtPoint: TGeoJSONPoint(FGeometry).Free;
      //gjtMultiPoint: TGeoJSONMultiPoint(FGeometry).Free;
    end;
  if Assigned(FProperties) then
    FProperties.Free;
  inherited Destroy;
end;

end.
