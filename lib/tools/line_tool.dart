import 'dart:html';

import 'Package:GraphicsApp/algorithms/line.dart';
import 'Package:GraphicsApp/math/point.dart';
import 'Package:GraphicsApp/math/segment.dart';
import 'Package:GraphicsApp/tools/tool.dart';
import 'Package:GraphicsApp/data/icons.dart';

enum State { SetStartPoint, SetEndPoint }

class LineTool extends Tool {
  State _state;
  Point2D _point;
  Line _tool;

  LineTool(Line tool) : super(new ToolMetadata('Line', Icons['line'])) {
    _state = State.SetStartPoint;
    _point = Point2DBuilder.defaultPoint();
    this.tool = tool;
  }

  @override
  void registrateEvents() {
    events['click'] = _click;
    events['mousemove'] = _move;
  }

  void _click(Event event) {
    window.requestAnimationFrame((time) {
      MouseEvent mouseEvent = event as MouseEvent;
      if (state == State.SetStartPoint) {
        _point = computePoint(mouseEvent, layer.body);
        _state = State.SetEndPoint;
      } else {
        Point2D endPoint = computePoint(mouseEvent, layer.body);
        tool.draw(layer.body, new Segment(point, endPoint));
        layer.preview.clearAll();
        _state = State.SetStartPoint;
      }
    });
  }

  void _move(Event event) {
    window.requestAnimationFrame((time) {
      if (state != State.SetEndPoint) return;
      MouseEvent mouseEvent = event as MouseEvent;
      layer.preview.clearAll();
      Point2D endPoint = computePoint(mouseEvent, layer.preview);
      tool.draw(layer.preview, new Segment(_point, endPoint));
    });
  }

  Point2D get point => _point;

  Line get tool => _tool;
  void set tool(Line tool) => _tool = tool;

  State get state => _state;
}
