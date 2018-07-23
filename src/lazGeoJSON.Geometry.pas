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
  Classes, SysUtils, lazGeoJSON;

type
{ TGeoJSONGeometryPosition }
  TGeoJSONGeometryPosition = class(TObject)
  private
    FLongitude: Double;
    FLatitude: Double;
    FAltitude: Double;
    FHasAltitude: Boolean;
  protected
  public
    constructor Create;

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
  end;

{ TGeoJSONGeometry }
  TGeoJSONGeometry = class (TGeoJSON)
  private
  protected
  public
  end;

implementation

{ TGeoJSONGeometryPosition }
constructor TGeoJSONGeometryPosition.Create;
begin
  FLongitude:= 0.0;
  FLatitude:= 0.0;
  FAltitude:= 0.0;
  FHasAltitude:= False;
end;

end.
