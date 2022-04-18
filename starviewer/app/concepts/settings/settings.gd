extends Node

"""
Will probably end up as some kind of singleton

Lots of utilities in here as well, ugh
"""

# For pretty printing elsewhere
var raw_settings: Dictionary

# Controlling debug statements, additional controls, etcetera
enum APP_MODE {UNSET, DEV, PROD}
var mode: int = APP_MODE.UNSET
func is_dev_mode():
  if mode == APP_MODE.DEV:
    return true
  return false

# Controlling which methods are used
enum APP_ENV {UNSET, NATIVE, WEB}
var env: int = APP_ENV.UNSET
func is_web_env():
  if env == APP_ENV.WEB:
    return true
  return false

# Web URL of Server folder containing individual 3D Model files
class ModelsInfo:
  var endpoints: String
var models: ModelsInfo = ModelsInfo.new()

# Web URL of Server folder containing individual 2D Image files
class TexturesInfo:
  var endpoints: String
var textures: TexturesInfo = TexturesInfo.new()

# Web URL of Server JSON file containing details on users and their stars
class StarsInfo:
  var endpoints: String
var stars: StarsInfo = StarsInfo.new()

func load_settings():
  """Load the Deployment Dictionary"""
  var acceptable_keys: Array = [
    "app_mode",
    "stars_endpoint",
    "models_endpoint",
    "textures_endpoint",
    "semantics"
   ]
  for potential_setting_name in raw_settings.keys():
    assert(acceptable_keys.has(potential_setting_name), "Unknown Setting: \"" + potential_setting_name + "\": \"" + raw_settings[potential_setting_name] + "\", please fix settings.json")
  for setting_name in raw_settings.keys():
    if setting_name == "app.mode":
      assert(raw_settings[setting_name] != "unset", "App Mode not set, please edit `StarViewerSettings` in `index.html`")
      assert(["dev","prod"].has(raw_settings[setting_name]), "Unknown App Mode: \"" + raw_settings[setting_name] + "\", please fix settings.json")
      if raw_settings[setting_name] == "dev":
        mode = APP_MODE.DEV
      if raw_settings[setting_name] == "prod":
        mode = APP_MODE.PROD
    if setting_name == "stars_endpoint":
      assert(raw_settings[setting_name] != "unset", "Stars Endpoint not set, please edit `StarViewerSettings` in `index.html`!")
      stars.endpoint = raw_settings[setting_name]
    if setting_name == "models_endpoint":
      assert(raw_settings[setting_name] != "unset", "Models Endpoint not set, please edit `StarViewerSettings` in `index.html`!")
      models.endpoint = raw_settings[setting_name]
    if setting_name == "textures_endpoint":
      assert(raw_settings[setting_name] != "unset", "Textures Endpoint not set, please edit `StarViewerSettings` in `index.html`!")
      textures.endpoint = raw_settings[setting_name]

func _init():
  if Utilities.dir_contents("user://").find("settings.json"):
    raw_settings = Utilities.load_json_file("user://settings.json")
    env = APP_ENV.NATIVE
  else:
    raw_settings = Utilities.load_json_string(JavaScript.eval("JSON.stringify(StarViewerSettings)"))
    env = APP_ENV.WEB
  load_settings()
