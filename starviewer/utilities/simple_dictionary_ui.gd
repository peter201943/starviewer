extends GridContainer
class_name SimpleDictionaryUI

"""
Constructs a 2D Control Panel with Spacing and Text from the Dictionary

Really ought to investigate adding a custom signal/method that tells this to "build" itself... Huh.
"""

enum DATA_TYPE {
  NULL = 0,
  BOOLEAN = 1,
  REAL_NUMBER = 3,
  STRING = 4,
  DICTIONARY = 18,
  ARRAY = 19,
}

export var data: Dictionary

var darkness = 0.1
var blueness = 0.1

func build():

  print("(DEBUG) SimpleDictionaryUI.build: Making new Instance")

  darkness += 0.05
  if darkness > 0.5: darkness = 0.1
  blueness += 0.1
  if blueness > 0.5: blueness = 0.1
  
  if typeof(data) == DATA_TYPE.DICTIONARY:
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
      
      self.add_child(panel)
    return
  
  if typeof(data) == DATA_TYPE.ARRAY:
    var entry_grid = GridContainer.new()
    entry_grid.columns = 1
    for entries in data:
      entry_grid.add_child(get_script().new(entries))
    self.add_child(entry_grid)
    return

  if [DATA_TYPE.BOOLEAN, DATA_TYPE.NULL, DATA_TYPE.REAL_NUMBER, DATA_TYPE.STRING].has(typeof(data)):
    var terminal = Label.new()
    terminal.text = str(data)
    self.add_child(terminal)
    return
