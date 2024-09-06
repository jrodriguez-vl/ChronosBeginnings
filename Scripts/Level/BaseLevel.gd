extends Node
class_name BaseLevel

@onready var pause: Node2D = preload("res://Scenes/GameManagement/PauseScene.tscn").instantiate()

var canPause = false

func _ready() -> void:
	if !Global.player:
		return

	
	pause.level = self
	add_child(pause)

	var playerPosition = get_node('Marker2D')

	if(playerPosition):
		Global.player.global_position = playerPosition.global_position
		Global.player.SetActive(true)

	canPause = true
