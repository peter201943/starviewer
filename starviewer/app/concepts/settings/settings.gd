extends Node

"""
Will probably end up as some kind of singleton

Lots of utilities in here as well, ugh
"""

enum APP_MODE {UNSET, DEV, PROD}

class Loader:
  """Handles loading a model/texture/userstars over either a Network or Local connection"""
  enum METHOD {UNSET, LOCAL, NETWORK}
  var method: int = Loader.METHOD.UNSET
  var route: String
  func get(name):
    if self.method == Loader.METHOD.LOCAL:
      print("TODO Local Loading not Implemented")
    elif self.method == Loader.METHOD.NETWORK:
      print("TODO Network Loading not Implemented")

# For pretty printing elsewhere
var raw_settings: Dictionary

# Controlling debug statements, additional controls, etcetera
var app_mode: int = APP_MODE.UNSET

# Primary method of accessing external models
var models: Loader = Loader.new()

# Primary method of accessing external textures
var textures: Loader = Loader.new()

# Primary method of finding user stars
var stars: Loader = Loader.new()

func load_json_file(path):
  """Loads a JSON file from the given res path and return the loaded JSON object."""
  var file = File.new()
  file.open(path, file.READ)
  var text = file.get_as_text()
  var result_json = JSON.parse(text)
  if result_json.error != OK:
    print("[load_json_file] Error loading JSON file '" + str(path) + "'.")
    print("\tError: ", result_json.error)
    print("\tError Line: ", result_json.error_line)
    print("\tError String: ", result_json.error_string)
    return null
  var obj = result_json.result
  return obj

func load_settings():
  """Load the Deployment JSON (settings.json)"""
  # Expects the settings file to accompany the `index.html`
  raw_settings = load_json_file("user://settings.json")
  var acceptable_keys: Array = [
    "app.mode",
    "stars.path",
    "stars.endpoint",
    "models.path",
    "models.endpoint",
    "textures.path",
    "textures.endpoint"
   ]
  # Check for any anomalous values and notify their existence
  for potential_setting_name in raw_settings.keys():
    assert(acceptable_keys.has(potential_setting_name), "Unknown Setting: \"" + potential_setting_name + "\": \"" + raw_settings[potential_setting_name] + "\", please fix settings.json")
  # Check for any mutually exclusive values whilst loading
  for setting_name in raw_settings.keys():
    # App Mode
    if setting_name == "app.mode":
      assert(["dev","prod"].has(raw_settings[setting_name]), "Unknown App Mode: \"" + raw_settings[setting_name] + "\", please fix settings.json")
      if raw_settings[setting_name] == "dev":
        app_mode = APP_MODE.DEV
      if raw_settings[setting_name] == "prod":
        app_mode = APP_MODE.PROD
    # Stars
    if setting_name == "stars.path":
      assert(stars.method == Loader.METHOD.UNSET, "Attempted to define Stars' settings twice, please fix settings.json")
      stars.method = Loader.METHOD.LOCAL
      stars.route = raw_settings[setting_name]
    if setting_name == "stars.endpoint":
      assert(stars.method == Loader.METHOD.UNSET, "Attempted to define Stars' settings twice, please fix settings.json")
      stars.method = Loader.METHOD.NETWORK
      stars.route = raw_settings[setting_name]
    # Models
    if setting_name == "models.path":
      assert(models.method == Loader.METHOD.UNSET, "Attempted to define Models' settings twice, please fix settings.json")
      models.method = Loader.METHOD.LOCAL
      models.route = raw_settings[setting_name]
    if setting_name == "models.endpoint":
      assert(models.method == Loader.METHOD.UNSET, "Attempted to define Models' settings twice, please fix settings.json")
      models.method = Loader.METHOD.NETWORK
      models.route = raw_settings[setting_name]
    # Textures
    if setting_name == "textures.path":
      assert(textures.method == Loader.METHOD.UNSET, "Attempted to define Textures' settings twice, please fix settings.json")
      textures.method = Loader.METHOD.LOCAL
      textures.route = raw_settings[setting_name]
    if setting_name == "textures.endpoint":
      assert(textures.method == Loader.METHOD.UNSET, "Attempted to define Textures' settings twice, please fix settings.json")
      textures.method = Loader.METHOD.NETWORK
      textures.route = raw_settings[setting_name]

func dir_contents(path):
  """Misc Helper for debugging, such as trying to locate `settings.json`"""
  var dir = Directory.new()
  var contents: String = ""
  if dir.open(path) == OK:
    dir.list_dir_begin()
    var file_name = dir.get_next()
    while file_name != "":
      if dir.current_is_dir():
        contents = contents + file_name+"/"+"\n"
      else:
        contents = contents + file_name+"\n"
      file_name = dir.get_next()
  else:
    contents = contents + "-- ERROR --" + "\n"
  return(contents)

var darkness = 0.1
var blueness = 0.1
func build_form(data):
  
  """
  Constructs a 2D Control Panel with Spacing and Text from the Dictionary
  """
  
  darkness += 0.05
  if darkness > 0.5: darkness = 0.1
  blueness += 0.1
  if blueness > 0.5: blueness = 0.1
  
  var grid = GridContainer.new()
  var data_type = "(???)"
  
  if typeof(data) == 18:
    data_type = "dict"
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
      entry_grid.add_child(build_form(entry_value))
      
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
      entry_grid.add_child(build_form(entries))
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

func _init():
  load_settings()
