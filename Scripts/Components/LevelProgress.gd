extends Node2D
class_name StairProgression

@export_file var nextLevel: String

@onready var stairs: Stairs = preload("res://Scenes/Accessory/Stairs.tscn").instantiate()
@onready var parent: BaseLevel = get_parent()

func _ready() -> void:
	stairs.nextLevel = nextLevel
	Events.ProgressLevel.connect(SpawnStaircase)


func SpawnStaircase(monsterPosition: Vector2) -> void:
	if(parent):
		parent.canPause = false

	stairs.global_position = monsterPosition
	add_child(stairs)
