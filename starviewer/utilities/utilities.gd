extends Node

"""
Various Helper Functions missing from Godot
"""

func dir_contents(path) -> String:
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

func load_json_file(path):
  """Loads a JSON file from the given res path and return the loaded JSON object."""
  var file = File.new()
  file.open(path, file.READ)
  var text = file.get_as_text()
  var result_json = JSON.parse(text)
  if result_json.error != OK:
    print("[load_json_file] Error loading JSON file '" + str(path) + "'.")
    print("\tError Message: ", result_json.error)
    print("\tError Line: ", result_json.error_line)
    print("\tError String: ", result_json.error_string)
    return null
  var obj = result_json.result
  return obj

func load_json_string(text):
  """Loads a JSON string from the given text and return the loaded JSON object."""
  var result_json = JSON.parse(text)
  if result_json.error != OK:
    print("[load_json_string] Error loading JSON string.")
    print("\tError Message: ", result_json.error)
    print("\tError Line: ", result_json.error_line)
    print("\tError String: ", result_json.error_string)
    return null
  var obj = result_json.result
  return obj

