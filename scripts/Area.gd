extends Area

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var used = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Area_body_entered( body ):
	if not used:
		if body is KinematicBody:
			used = true
			print("trapped!")
			var wall = get_node("../wall")
			var old = wall.translation
			old.z = -9.71
			wall.translation = old
			# change wall color?
#			var color = Color(255,0,0,1)
#			var material = wall.get_node("MeshInstance")
#			print(str(material))
#			material = material.get_surface_material(0)
#			wall.get_node("MeshInstance").set_surface_material(0, material)