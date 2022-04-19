extends Node

"""
Basic First-Person "Behavioral" Control Script

Expects this structure:

```
Spatial:
  Spatial:
    Node: (Script attached here)
```

HELP: https://docs.godotengine.org/en/stable/tutorials/3d/fps_tutorial/part_one.html
"""

export var y_sensitivity = 0.3
export var x_sensitivity = 0.3

onready var body: KinematicBody = get_parent().get_parent()
onready var head: Spatial = get_parent()

var velocity: Vector3 = Vector3()
var direction: Vector3 = Vector3()

export var speed = 10
export var acceleration = 10
export var active = false

func _ready():
  if active:
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
  # Mouse Look
  if event is InputEventMouseMotion and active:
    body.rotate_y(deg2rad(event.relative.x * y_sensitivity * -1))
    head.rotate_x(deg2rad(event.relative.y * x_sensitivity * -1))
    head.rotation.x = clamp(head.rotation.x, deg2rad(-70), deg2rad(70))
    head.rotation.z = 0

func _process(delta):
  
  # (Cancel) Set/Reset Mouselook Controls
  if Input.is_action_just_pressed("ui_cancel") or Input.is_action_just_pressed("misc_toggle"):
    if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
      Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
      active = false
      velocity = Vector3()
      direction = Vector3()
    else:
      Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
      active = true
  if not active: return
  
  # Reset Movement
  direction = Vector3(0.0, 0.0, 0.0)
  
  # Default FPS Controller Movement using the Arrow keys
  if Input.is_action_pressed("ui_up"):
    direction -= body.transform.basis.z
  elif Input.is_action_pressed("ui_down"):
    direction += body.transform.basis.z
  if Input.is_action_pressed("ui_left"):
    direction -= body.transform.basis.x
  elif Input.is_action_pressed("ui_right"):
    direction += body.transform.basis.x
  if Input.is_action_pressed("ui_page_down"):
    direction -= body.transform.basis.y
  elif Input.is_action_pressed("ui_page_up"):
    direction += body.transform.basis.y
  
  # Apply Movement
  velocity = velocity.linear_interpolate(direction.normalized() * speed, acceleration * delta)
  velocity = body.move_and_slide(velocity, Vector3.UP)


