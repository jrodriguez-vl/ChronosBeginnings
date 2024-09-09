extends Node
class_name BaseLevel

@export var enemiesAlwaysChase: bool = false
@onready var pause: Node2D = preload("res://Scenes/GameManagement/PauseScene.tscn").instantiate()

var canPause = false

func _ready() -> void:
	if !Global.player:
		return

	Global.EnemiesAlwaysChase = enemiesAlwaysChase
	
	pause.level = self
	add_child(pause)

	var playerPosition = get_node('Marker2D')

	if(playerPosition):
		Global.player.global_position = playerPosition.global_position
		Global.player.SetActive(true)

	canPause = true
