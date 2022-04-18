extends Node

"""
Will probably end up as some kind of singleton
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
  var settings_map: Dictionary = load_json_file("user://settings.json")
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
  for potential_setting_name in settings_map.keys():
    assert(acceptable_keys.has(potential_setting_name), "Unknown Setting: \"" + potential_setting_name + "\": \"" + settings_map[potential_setting_name] + "\", please fix settings.json")
  # Check for any mutually exclusive values whilst loading
  for setting_name in settings_map.keys():
    # App Mode
    if setting_name == "app.mode":
      assert(["dev","prod"].has(settings_map[setting_name]), "Unknown App Mode: \"" + settings_map[setting_name] + "\", please fix settings.json")
      if settings_map[setting_name] == "dev":
        app_mode = APP_MODE.DEV
      if settings_map[setting_name] == "prod":
        app_mode = APP_MODE.PROD
    # Stars
    if setting_name == "stars.path":
      assert(stars.method == Loader.METHOD.UNSET, "Attempted to define Stars' settings twice, please fix settings.json")
      stars.method = Loader.METHOD.LOCAL
      stars.route = settings_map[setting_name]
    if setting_name == "stars.endpoint":
      assert(stars.method == Loader.METHOD.UNSET, "Attempted to define Stars' settings twice, please fix settings.json")
      stars.method = Loader.METHOD.NETWORK
      stars.route = settings_map[setting_name]
    # Models
    if setting_name == "models.path":
      assert(models.method == Loader.METHOD.UNSET, "Attempted to define Models' settings twice, please fix settings.json")
      models.method = Loader.METHOD.LOCAL
      models.route = settings_map[setting_name]
    if setting_name == "models.endpoint":
      assert(models.method == Loader.METHOD.UNSET, "Attempted to define Models' settings twice, please fix settings.json")
      models.method = Loader.METHOD.NETWORK
      models.route = settings_map[setting_name]
    # Textures
    if setting_name == "textures.path":
      assert(textures.method == Loader.METHOD.UNSET, "Attempted to define Textures' settings twice, please fix settings.json")
      textures.method = Loader.METHOD.LOCAL
      textures.route = settings_map[setting_name]
    if setting_name == "textures.endpoint":
      assert(textures.method == Loader.METHOD.UNSET, "Attempted to define Textures' settings twice, please fix settings.json")
      textures.method = Loader.METHOD.NETWORK
      textures.route = settings_map[setting_name]

func dir_contents(path):
  """Misc Helper for debugging, such as trying to locate `settings.json`"""
  var dir = Directory.new()
  if dir.open(path) == OK:
    dir.list_dir_begin()
    var file_name = dir.get_next()
    while file_name != "":
      if dir.current_is_dir():
        print(file_name+"/")
      else:
        print(file_name)
      file_name = dir.get_next()
  else:
    print("An error occurred when trying to access the path.")

func _init():
  load_settings()
