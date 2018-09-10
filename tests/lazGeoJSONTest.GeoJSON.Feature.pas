{
  GeoJSON/Feature Object Test

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
unit lazGeoJSONTest.GeoJSON.Feature;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, {testutils,} testregistry, fpjson,
  lazGeoJSON,
  lazGeoJSON.Utils,
  lazGeoJSON.Feature;

type

{ TTestGeoJSONFeature }
  TTestGeoJSONFeature = class(TTestCase)
  private
    FGeoJSONFeature: TGeoJSONFeature;
  protected
  public
  published
    procedure TestFeatureCreate;

    procedure TestFeatureCreateJSONWrongObject;
    procedure TestFeatureCreateJSONWrongFormedObjectWithEmptyObject;
    procedure TestFeatureCreateJSONWrongFormedObjectWithMissingMember;
    procedure TestFeatureCreateJSON;
    procedure TestFeatureCreateJSONWithProperties;
    procedure TestFeatureCreateJSONWithIDProperties;

    procedure TestFeatureCreateJSONDataWrongObject;

    procedure TestFeatureAsJSON;
    procedure TestFeatureAsJSONWithProperties;
    procedure TestFeatureAsJSONWithIDProperties;
  end;

implementation

uses
  lazGeoJSONTest.Common;

{ TTestGeoJSONFeature }

procedure TTestGeoJSONFeature.TestFeatureCreate;
begin
  FGeoJSONFeature:= TGeoJSONFeature.Create;
  AssertEquals('GeoJSON Object Type gjtFeature', Ord(gjtFeature), Ord(FGeoJSONFeature.GeoJSONType));
  AssertEquals('Feature HasID False', False, FGeoJSONFeature.HasID);
  AssertEquals('Feature ID empty', '', FGeoJSONFeature.ID);
  AssertNull('Feature Geometry nil', FGeoJSONFeature.Geometry);
  AssertEquals('Feature HasProperties False', False, FGeoJSONFeature.HasProperties);
  FGeoJSONFeature.Free;
end;

procedure TTestGeoJSONFeature.TestFeatureCreateJSONWrongObject;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONFeature:= TGeoJSONFeature.Create(cJSONEmptyArray);
    except
      on e: EFeatureWrongObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONFeature.Free;
  end;
  AssertEquals('Got Exception EFeatureWrongObject on empty array', True, gotException);
end;

procedure TTestGeoJSONFeature.TestFeatureCreateJSONWrongFormedObjectWithEmptyObject;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONFeature:= TGeoJSONFeature.Create(cJSONEmptyObject);
    except
      on e: EFeatureWrongFormedObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONFeature.Free;
  end;
  AssertEquals('Got Exception EFeatureWrongFormedObject on empty object', True, gotException);
end;

procedure TTestGeoJSONFeature.TestFeatureCreateJSONWrongFormedObjectWithMissingMember;
var
  gotException: Boolean;
begin
  gotException:= False;
  try
    try
      FGeoJSONFeature:= TGeoJSONFeature.Create(cJSONFeatureNoGeometry);
    except
      on e: EFeatureWrongFormedObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONFeature.Free;
  end;
  AssertEquals('Got Exception EPointWrongFormedObject on object missing member', True, gotException);
end;

procedure TTestGeoJSONFeature.TestFeatureCreateJSON;
begin
  FGeoJSONFeature:= TGeoJSONFeature.Create(cJSONFeature);
  AssertEquals('GeoJSON Object Type gjtFeature', Ord(gjtFeature), Ord(FGeoJSONFeature.GeoJSONType));
  AssertEquals('Feature HasID False', False, FGeoJSONFeature.HasID);
  AssertEquals('Feature ID empty', '', FGeoJSONFeature.ID);
  AssertNotNull('Feature Geometry not nil', FGeoJSONFeature.Geometry);
  AssertEquals('Feature HasProperties False', False, FGeoJSONFeature.HasProperties);
  FGeoJSONFeature.Free;
end;

procedure TTestGeoJSONFeature.TestFeatureCreateJSONWithProperties;
begin
  FGeoJSONFeature:= TGeoJSONFeature.Create(cJSONFeatureProperties);
  AssertEquals('GeoJSON Object Type gjtFeature', Ord(gjtFeature), Ord(FGeoJSONFeature.GeoJSONType));
  AssertEquals('Feature HasID False', False, FGeoJSONFeature.HasID);
  AssertEquals('Feature ID empty', '', FGeoJSONFeature.ID);
  AssertNotNull('Feature Geometry not nil', FGeoJSONFeature.Geometry);
  AssertEquals('Feature HasProperties True', True, FGeoJSONFeature.HasProperties);
  FGeoJSONFeature.Free;
end;

procedure TTestGeoJSONFeature.TestFeatureCreateJSONWithIDProperties;
begin
  FGeoJSONFeature:= TGeoJSONFeature.Create(cJSONFeatureIDProperties);
  AssertEquals('GeoJSON Object Type gjtFeature', Ord(gjtFeature), Ord(FGeoJSONFeature.GeoJSONType));
  AssertEquals('Feature HasID True', True, FGeoJSONFeature.HasID);
  AssertEquals('Feature ID Feature001', 'Feature001', FGeoJSONFeature.ID);
  AssertNotNull('Feature Geometry not nil', FGeoJSONFeature.Geometry);
  AssertEquals('Feature HasProperties True', True, FGeoJSONFeature.HasProperties);
  FGeoJSONFeature.Free;
end;

procedure TTestGeoJSONFeature.TestFeatureCreateJSONDataWrongObject;
var
  gotException: Boolean;
  jData: TJSONData;
begin
  gotException:= False;
  jData:= GetJSONData(cJSONEmptyArray);
  try
    try
      FGeoJSONFeature:= TGeoJSONFeature.Create(jData);
    except
      on e: EFeatureWrongObject do
      begin
        gotException:= True;
      end;
    end;
  finally
    FGeoJSONFeature.Free;
  end;
  jData.Free;
  AssertEquals('Got Exception EFeatureWrongObject on empty array', True, gotException);
end;

procedure TTestGeoJSONFeature.TestFeatureAsJSON;
begin
  FGeoJSONFeature:= TGeoJSONFeature.Create(cJSONFeature);
  AssertEquals('Feature asJSON', cJSONFeature, FGeoJSONFeature.asJSON);
  FGeoJSONFeature.Free;
end;

procedure TTestGeoJSONFeature.TestFeatureAsJSONWithProperties;
begin
  FGeoJSONFeature:= TGeoJSONFeature.Create(cJSONFeatureProperties);
  AssertEquals('Feature asJSON Properties', cJSONFeatureProperties, FGeoJSONFeature.asJSON);
  FGeoJSONFeature.Free;
end;

procedure TTestGeoJSONFeature.TestFeatureAsJSONWithIDProperties;
begin
  FGeoJSONFeature:= TGeoJSONFeature.Create(cJSONFeatureIDProperties);
  AssertEquals('Feature asJSON ID Properties', cJSONFeatureIDProperties, FGeoJSONFeature.asJSON);
  FGeoJSONFeature.Free;
end;

initialization
  RegisterTest(TTestGeoJSONFeature);
end.
