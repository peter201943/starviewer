extends GridContainer
class_name SimpleDictionaryUI

"""
Constructs a 2D Control Panel with Spacing and Text from the Dictionary
"""

# For controlling how items are printed
enum DATA_TYPE {
  NULL = 0,
  BOOLEAN = 1,
  REAL_NUMBER = 3,
  STRING = 4,
  DICTIONARY = 18,
  ARRAY = 19,
}

# In case someone wants to define a SimpleDictionaryUI from the editor.
# Will attempt to be loaded by `build` if `data` is `null`
export var editor_data: String

# The actual data
var data

var darkness = 0.1
var blueness = 0.1

func build():
  
  # Check if `editor_data` has been set if `data` is empty before printing it
  if typeof(data) == DATA_TYPE.NULL:
    if editor_data.length() > 1:
      data = Utilities.load_json_string(editor_data)

  # Set color to be slightly different each time
  darkness += 0.05
  if darkness > 0.5: darkness = 0.1
  blueness += 0.1
  if blueness > 0.5: blueness = 0.1
  
  # Add dictionary keys as vertical stacks
  if typeof(data) == DATA_TYPE.DICTIONARY:
    for key in data.keys():
      var entry_value = data[key]
      var entry_grid = GridContainer.new()
      entry_grid.columns = 3
      var key_label = Label.new()
      key_label.name = "key"
      key_label.text = str(key)
      key_label.add_color_override("font_color", Color(0,1,0,1))
      entry_grid.add_child(key_label)
      entry_grid.add_child(VSeparator.new())
      var next_frame = get_script().new()
      next_frame.data = entry_value
      next_frame.build()
      entry_grid.add_child(next_frame)
      
      var panel = PanelContainer.new()
      panel.name = "panel"
      var style = StyleBoxFlat.new()
      style.bg_color = Color(darkness,darkness,darkness + blueness,1)
      panel.add_stylebox_override("panel", style)
      panel.add_child(entry_grid)
      
      self.add_child(panel)
    return
  
  # Add Lists as Vertical Stacks
  if typeof(data) == DATA_TYPE.ARRAY:
    var entry_grid = GridContainer.new()
    entry_grid.columns = 1
    for entries in data:
      var next_frame = get_script().new()
      next_frame.data = entries
      next_frame.build()
      entry_grid.add_child(next_frame)
    self.add_child(entry_grid)
    return

  # Any other recognizable type of basic data
  if [DATA_TYPE.BOOLEAN, DATA_TYPE.NULL, DATA_TYPE.REAL_NUMBER, DATA_TYPE.STRING].has(typeof(data)):
    var terminal = Label.new()
    terminal.text = str(data)
    self.add_child(terminal)
    return
  
  # For any other unrecognizable kind of data
  var terminal = Label.new()
  terminal.text = str(data)
  self.add_child(terminal)
  return
