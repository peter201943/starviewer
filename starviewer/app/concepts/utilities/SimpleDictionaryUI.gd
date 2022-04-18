extends GridContainer
class_name SimpleDictionaryUI

"""
Constructs a 2D Control Panel with Spacing and Text from the Dictionary
"""

enum DATA_TYPE {
  NULL = 0,
  BOOLEAN = 1,
  REAL_NUMBER = 3,
  STRING = 4,
  DICTIONARY = 18,
  ARRAY = 19,
}

var darkness = 0.1
var blueness = 0.1

func _init(data):

  print("(DEBUG) SimpleDictionaryUI._init: Making new Instance")

  darkness += 0.05
  if darkness > 0.5: darkness = 0.1
  blueness += 0.1
  if blueness > 0.5: blueness = 0.1
  
  var grid = GridContainer.new()
  var data_type = "(???)"
  
  if typeof(data) == 18:
    data_type = "dict"
    for key in data.keys():
      print("(DEBUG) SimpleDictionaryUI._init: Adding Key: " + key)
      var entry_value = data[key]
      var entry_grid = GridContainer.new()
      entry_grid.columns = 3
      var key_label = Label.new()
      key_label.name = "key"
      key_label.text = str(key)
      key_label.add_color_override("font_color", Color(0,1,0,1))
      entry_grid.add_child(key_label)
      entry_grid.add_child(VSeparator.new())
      entry_grid.add_child(get_script().new(entry_value))
      
      var panel = PanelContainer.new()
      panel.name = "panel"
      var style = StyleBoxFlat.new()
      style.bg_color = Color(darkness,darkness,darkness + blueness,1)
      panel.add_stylebox_override("panel", style)
      panel.add_child(entry_grid)
      
      grid.add_child(panel)
    return grid
  
  if typeof(data) == 19:
    data_type = "array"
    var entry_grid = GridContainer.new()
    entry_grid.columns = 1
    for entries in data:
      entry_grid.add_child(get_script().new(entries))
    grid.add_child(entry_grid)
    return grid

  if typeof(data) == 4: data_type = "string"
  if typeof(data) == 3: data_type = "real number"
  if typeof(data) == 1: data_type = "boolean"
  if typeof(data) == 0: data_type = "null pointer"
  var terminal = Label.new()
  terminal.text = str(data)
  grid.add_child(terminal)
  return grid
