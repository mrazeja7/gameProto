extends KinematicBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var speed = 300
var direction = Vector3()
var gravity = -9.8
var velocity = Vector3()

var view_sensitivity = 0.3
var yaw = 0
var pitch = 0
const max_accel = 0.02
const air_accel = 0.1

func _ready():
	set_process_input(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _enter_scene():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _exit_scene():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	var aim = get_node("yaw").get_global_transform().basis
#	print(str(aim))
#	direction = Vector3()
#	if Input.is_action_pressed("ui_left"):
#		direction.x -= 1
#	if Input.is_action_pressed("ui_right"):
#		direction.x += 1
#	if Input.is_action_pressed("ui_up"):
#		direction.z -= 1
#	if Input.is_action_pressed("ui_down"):
#		direction.z += 1
	direction = Vector3()
	if Input.is_action_pressed("ui_left"):
		direction -= aim[0]
	if Input.is_action_pressed("ui_right"):
		direction += aim[0]
	if Input.is_action_pressed("ui_up"):
		direction -= aim[2]
	if Input.is_action_pressed("ui_down"):
		direction += aim[2]
	
	direction = direction.normalized()
	direction = direction * speed * delta
	
	if velocity.y > 0:
		gravity = -20
	else:
		gravity = -30
	velocity.y += gravity * delta
	velocity.x = direction.x
	velocity.z = direction.z
	
	velocity = move_and_slide(velocity, Vector3(0, 1, 0))
		
	#jump
	if is_on_floor() and Input.is_key_pressed(KEY_SPACE):
		velocity.y = 10
		
func _input(ie):
	if ie is InputEventKey and Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
		pass
		
	#mouse movement
	if ie is InputEventMouseMotion:
		yaw = fmod(yaw - ie.relative.x * view_sensitivity, 360)
		pitch = max(min(pitch - ie.relative.y * view_sensitivity, 90), -90)
		set_rotation(Vector3(0, deg2rad(yaw), 0))
		get_node("yaw/Camera").set_rotation(Vector3(deg2rad(pitch), 0, 0))