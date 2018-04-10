import 'dart:html';

import 'Package:GraphicsApp/algorithms/cda_line.dart';
import 'Package:GraphicsApp/algorithms/bresenham_line.dart';
import 'Package:GraphicsApp/algorithms/circle.dart';
import 'Package:GraphicsApp/tools/tool.dart';
import 'Package:GraphicsApp/tools/line_tool.dart';
import 'Package:GraphicsApp/tools/circle_tool.dart';
import 'Package:GraphicsApp/view/layer.dart';

import 'package:GraphicsApp/algorithms/simple_fill.dart';
import 'package:GraphicsApp/algorithms/stroke_fill.dart';
import 'package:GraphicsApp/components/colorPicker.dart';
import 'package:GraphicsApp/components/toolbox.dart';
import 'package:GraphicsApp/data/color.dart';
import 'package:GraphicsApp/services/draw_manager.dart';
import 'package:GraphicsApp/tools/simple_fill_tool.dart';
import 'package:GraphicsApp/tools/stroke_fill_tool.dart';
import 'package:GraphicsApp/tools/tools.dart';
import 'package:GraphicsApp/components/card.dart';

void initializeApp() {
  Layer mainLayer = new Layer(640, 480);

  ColorPicker colorPicker = new ColorPicker();

  LineTool cdaLine = new LineTool(new CDALine(colorPicker.color, 1));
  LineTool bresenhamLine =
      new LineTool(new BresenhamLine(colorPicker.color, 1));

  CircleTool circle = new CircleTool(new Circle(colorPicker.color, 1));

  SimpleFillTool simpleFillTool =
      new SimpleFillTool(new SimpleFill(colorPicker.color));

  StrokeFillTool strokeFillTool =
      new StrokeFillTool(new StrokeFill(colorPicker.color));

  Tools tools = new Tools();
  Toolbox toolbox = new Toolbox(tools);

  tools.addTool(cdaLine);
  tools.addTool(bresenhamLine);
  tools.addTool(circle);
  tools.addTool(simpleFillTool);
  tools.addTool(strokeFillTool);

  CardComponent toolsCard = new CardComponent("Tools", toolbox.render);
  CardComponent colorPickerCard =
      new CardComponent("ColorPicker", colorPicker.render);

  DrawManager manager = new DrawManager(tools);
  manager.layer = mainLayer;

  document.querySelector('#mainFrame').append(toolsCard.render);
  document.querySelector('#mainFrame').append(mainLayer.render);
  document.querySelector('#mainFrame').append(colorPickerCard.render);
}
