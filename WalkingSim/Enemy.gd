extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@onready var player = get_node("/root/World/Player")

var movement_speed = 5

func _ready():
	call_deferred("get_target")
	
func get_target():
	nav_agent.target_position = player.global_transform.origin
	
func _physics_process(delta):
	look_at(player.global_position)
	rotation_degrees.x = 0
	rotation_degrees.z = 0
	if nav_agent.is_navigation_finished():
		get_target()
		
	var current_position = global_position
	var next_position = nav_agent.get_next_path_position()
	var new_velocity = next_position - current_position
	new_velocity = new_velocity.normalized() * movement_speed
	
	velocity = new_velocity
	move_and_slide()
		
	
