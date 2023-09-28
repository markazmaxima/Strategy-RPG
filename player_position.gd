extends Label

@onready var player_detail = $"/root/Global"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pos = player_detail.player_position
	text = "player coor: " + str(pos)
