extends CharacterBody2D
@onready var get_player_position = $"/root/Global"

const speed = 500
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var chase = false
var player = null

signal move_left
signal move_right

func _physics_process(delta):
	
	$animation.play()
	
	if chase:
		var pas = player.position - position
		pas = pas.x
		$DebugLook.look_at(player.position)
		
		if pas < 0:
			velocity.x = -speed
		else:
			velocity.x = speed
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()


func _on_detect_range_body_entered(body):
	player = body
	chase = true
	
	


func _on_detect_range_body_exited(_body):
	player = null
	chase = false
	
	velocity.x = 0
