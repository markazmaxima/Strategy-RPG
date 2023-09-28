extends CharacterBody2D

@onready var _playerDeb = $DebugArrow

const speed = 50.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var damage_player = $"/root/Global"
var player_chase = false
var player = null
var atk = 2

signal hityou

func _physics_process(delta):
	
	if player_chase:
		position += (player.position - position)/speed
			
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()


func _on_detection_area_body_entered(body):
	player = body
	player_chase = true
	
	emit_signal("hityou")
	
	damage_player.trans_damage = 2
	
	


func _on_detection_area_body_exited(body):
	player = null
	player_chase = false
