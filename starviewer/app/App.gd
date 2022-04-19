extends Node

"""
App Settings Singleton

Holds Users, Models, Textures accessors and app flags
"""

# For pretty printing elsewhere
var settings: Dictionary

# Controlling debug statements, additional controls, etcetera
var is_dev_mode: bool = false

# Controlling which methods are used
var is_native: bool = false

# Web URL of Server folder containing individual 3D Model files
var models: StarViewerModels = StarViewerModels.new()

# Web URL of Server folder containing individual 2D Image files
var textures: StarViewerTextures = StarViewerTextures.new()

# Web URL of Server JSON file containing details on users and their stars
var users: StarViewerUsers = StarViewerUsers.new()

func _init():
  """Load the Deployment Dictionary"""
  
  # Find and set app flags
  if Utilities.dir_contents("user://").find("settings.json"):
    settings = Utilities.load_json_file("user://settings.json")
    is_native = true
  else:
    settings = Utilities.load_json_string(JavaScript.eval("JSON.stringify(StarViewerSettings)"))
    is_native = false
  
  # A simple test to see if the dictionary is valid
  var acceptable_toplevel_keys: Array = [
    "app",
    "users",
    "models",
    "textures",
    "semantics"
   ]
  for potential_setting_name in settings.keys():
    assert(
      acceptable_toplevel_keys.has(potential_setting_name),
      "Unknown Setting: \"" + potential_setting_name + "\": \"" + String(settings[potential_setting_name]) + "\", please fix settings.json"
    )

  # Now read and load the dictionary
  for setting_name in settings.keys():
    
    # App Settings
    if setting_name == "app":
      var app_settings = settings[setting_name]
      for app_setting_name in app_settings.keys():
        if app_setting_name == "mode":
          var app_mode = app_settings[app_setting_name]
          assert(
            ["dev","prod"].has(app_mode),
            "Unknown App Mode: \"" + String(app_mode) + "\", please fix settings.json"
          )
          if app_mode == "dev":
            is_dev_mode = true
          if app_mode == "prod":
            is_dev_mode = false
            
    # Users Settings (`stars.json`)
    if setting_name == "users":
      var users_settings = settings[setting_name]
      for users_setting_name in users_settings:
        if users_setting_name == "endpoint":
          var users_endpoint = users_settings[users_setting_name]
          assert(users_endpoint != "unset", "Users Endpoint not set, please edit `StarViewerSettings` in `index.html`!")
          users.endpoint = users_endpoint
    
    # Models Settings
    if setting_name == "models":
      var models_settings = settings[setting_name]
      for models_setting_name in models_settings:
        if models_setting_name == "endpoint":
          var models_endpoint = models_settings[models_setting_name]
          assert(models_endpoint != "unset", "Models Endpoint not set, please edit `StarViewerSettings` in `index.html`!")
          models.endpoint = models_endpoint
    
    # Textures Settings
    if setting_name == "textures":
      var textures_settings = settings[setting_name]
      for textures_setting_name in textures_settings:
        if textures_setting_name == "endpoint":
          var textures_endpoint = textures_settings[textures_setting_name]
          assert(textures_endpoint != "unset", "Textures Endpoint not set, please edit `StarViewerSettings` in `index.html`!")
          textures.endpoint = textures_endpoint
