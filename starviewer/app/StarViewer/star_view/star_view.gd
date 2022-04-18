extends Control

onready var sfx_btn_enter: AudioStreamPlayer = get_node("sfx_btn_enter")
onready var sfx_btn_exit: AudioStreamPlayer = get_node("sfx_btn_exit")
onready var sfx_btn_press: AudioStreamPlayer = get_node("sfx_btn_press")

var pressed = false

var info_box: VSplitContainer

func _on_prev_star_pressed():
  sfx_btn_press.play()
  pressed = true
  print("TODO open previous star")

func _on_next_star_pressed():
  sfx_btn_press.play()
  pressed = true
  print("TODO open next star")

func _on_search_pressed():
  sfx_btn_press.play()
  pressed = true
  print("TODO open search")

func _on_info_pressed():
  sfx_btn_press.play()
  pressed = true
  if is_instance_valid(info_box):
    info_box.queue_free()
    return
  var dir_info = Label.new()
  dir_info.text = \
    "# user://" + \
    " (" + ProjectSettings.globalize_path("user://") + ")\n" + \
    Utilities.dir_contents("user://") + \
    "# res://" + \
    " (" + ProjectSettings.globalize_path("res://") + ")\n" + \
    Utilities.dir_contents("res://")
  var settings_info = SimpleDictionaryUI.new(Settings.raw_settings)
  info_box = VSplitContainer.new()
  self.add_child(info_box)
  info_box.add_child(settings_info)
  info_box.add_child(dir_info)
  if Settings.is_web_env():
    JavaScript.eval("alert(`(TEMP) StarViewerSettings: ${JSON.stringify(StarViewerSettings)}`);")

func _on_button_entered():
  sfx_btn_enter.play()

func _on_button_exited():
  if pressed:
    pressed = false
    return
  sfx_btn_exit.play()
