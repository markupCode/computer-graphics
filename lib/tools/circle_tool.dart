import 'dart:html';

import 'Package:GraphicsApp/tools/tool.dart';
import 'Package:GraphicsApp/algorithms/circle.dart';
import 'Package:GraphicsApp/math/point.dart';
import 'Package:GraphicsApp/math/segment.dart';
import 'Package:GraphicsApp/data/icons.dart';

enum State { SetStartPoint, SetEndPoint }

class CircleTool extends Tool {
  State _state;
  Point2D _point;
  Circle _tool;

  CircleTool(Circle tool) : super(new ToolMetadata('circle', Icons['circle'])) {
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
      if (_state != State.SetEndPoint) return;
      MouseEvent mouseEvent = event as MouseEvent;
      layer.preview.clearAll();
      Point2D endPoint = computePoint(mouseEvent, layer.preview);
      tool.draw(layer.preview, new Segment(_point, endPoint));
    });
  }

  State get state => _state;

  Point2D get point => _point;

  Circle get tool => _tool;
  void set tool(Circle tool) => _tool = tool;
}
