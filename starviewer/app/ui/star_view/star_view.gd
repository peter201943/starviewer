extends Control

onready var sfx_btn_enter: AudioStreamPlayer = get_node("sfx_btn_enter")
onready var sfx_btn_exit: AudioStreamPlayer = get_node("sfx_btn_exit")
onready var sfx_btn_press: AudioStreamPlayer = get_node("sfx_btn_press")

var pressed = false

var info_label: GridContainer

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
  if is_instance_valid(info_label):
    info_label.queue_free()
    return
  # info_label = Label.new()
  # info_label.text = \
  #   "app_mode: " + "FIXME" + "\n" + \
  #   "stars: (" + "FIXME" + ") FIXME" + "\n" + \
  #   "models: (" + "FIXME" + ") FIXME" + "\n" + \
  #   "textures: (" + "FIXME" + ") FIXME" + "\n"
  info_label = Settings.build_form(Settings.raw_settings)
  self.add_child(info_label)
  print("TODO open info")

func _on_button_entered():
  sfx_btn_enter.play()

func _on_button_exited():
  if pressed:
    pressed = false
    return
  sfx_btn_exit.play()

