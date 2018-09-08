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

{ TGeoJSONFeature }
  TGeoJSONFeature = class(TGeoJSON)
  private
    FPoint: TGeoJSONPoint;
  protected
  public
    constructor Create;
    destructor Destroy; override;

    property Point: TGeoJSONPoint
      read FPoint;
  end;

implementation

{ TGeoJSONFeature }

constructor TGeoJSONFeature.Create;
begin
  FGJType:= gjtFeature;
  FPoint:= TGeoJSONPoint.Create;
end;

destructor TGeoJSONFeature.Destroy;
begin
  if Assigned(FPoint) then
    FPoint.Free;
  inherited Destroy;
end;

end.
