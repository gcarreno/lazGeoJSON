{
  Common Tests Code

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
unit lazGeoJSONTest.Common;


{$mode objfpc}{$H+}

interface

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
  cJSONPositionArrayOneItemI =
    '[100]';
  cJSONPositionArrayTwoItemsI =
    '[100, -100]';
  cJSONPositionArrayThreeItemsI =
    '[100, -100, 100]';
  cJSONPositionArrayFourItemsI =
    '[100, -100, 100, 100]';
  cJSONPositionArrayOneItemD =
    '[100.12]';
  cJSONPositionArrayTwoItemsD =
    '[100.12, -100.12]';
  cJSONPositionArrayThreeItemsD =
    '[100.12, -100.12, 100.12]';
  cJSONPositionArrayFourItemsD =
    '[100.12, -100.12, 100.12, 100.12]';

// TGeoJSONPoint
  cJSONPointObjectNoPosition =
    '{"type": "Point"}';
  cJSONPointObject =
    '{"type": "Point", "coordinates": [100, -100]}';

// TGeoJSONFeature
  cJSONFeatureNoGeometry =
    '{"type": "Feature"}';
  cJSONFeatureProperties =
    '{"type": "Feature", "geometry": {"type": "Point", "coordinates": [100, -100]}, "properties": {"p1":"p1 value","p2":"p2 value"}}';
  cJSONFeature =
    '{"type": "Feature", "geometry": {"type": "Point", "coordinates": [100, -100]}}';
  cJSONFeatureStationML =
    '{'+
    '    "type": "Feature",'+
    '    "geometry": {'+
    '        "type": "Point",'+
    '        "coordinates": ['+
    '            -2.883333,'+
    '            54.066666'+
    '        ]'+
    '    },'+
    '    "properties": {'+
    '        "Id": "0440B",'+
    '        "Name": "Morecambe",'+
    '        "Country": "England",'+
    '        "ContinuousHeightsAvailable": true,'+
    '        "Footnote": null'+
    '    }'+
    '}';
  cJSONFeatureStation =
    '{"type": "Feature", "geometry": {"type": "Point", "coordinates": [-2.883333, 54.066666]}, "properties": {"Id":"0440B","Name":"Morecambe","Country":"England","ContinuousHeightsAvailable":true,"Footnote":null}}';

implementation

end.
