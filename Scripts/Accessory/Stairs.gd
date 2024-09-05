extends Node2D
class_name Stairs

var level: BaseLevel
@export var nextLevel: String

func _on_static_body_2d_area_entered(_area: Area2D) -> void:
	level.canPause = false
	Global.mainScene.SceneTransition(nextLevel)
