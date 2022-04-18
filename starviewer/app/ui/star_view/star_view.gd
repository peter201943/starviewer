extends Control

onready var sfx_btn_enter: AudioStreamPlayer = get_node("sfx_btn_enter")
onready var sfx_btn_exit: AudioStreamPlayer = get_node("sfx_btn_exit")
onready var sfx_btn_press: AudioStreamPlayer = get_node("sfx_btn_press")

func _on_prev_star_pressed():
  sfx_btn_press.play()
  print("TODO open previous star")

func _on_next_star_pressed():
  sfx_btn_press.play()
  print("TODO open next star")

func _on_search_pressed():
  sfx_btn_press.play()
  print("TODO open search")

func _on_button_entered():
  sfx_btn_enter.play()

func _on_button_exited():
  sfx_btn_exit.play()
