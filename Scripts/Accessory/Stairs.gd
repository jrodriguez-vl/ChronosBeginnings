extends Node2D
class_name Stairs

@export var nextLevel: String

func _on_static_body_2d_area_entered(area: Area2D) -> void:
	Global.mainScene.SceneTransition(nextLevel)
