extends Node2D
class_name Stairs

@export var nextLevel: PackedScene
@export var nextLevel2: PackedScene
@export_file var targetLevel: String

func _on_static_body_2d_area_entered(area: Area2D) -> void:
	Global.mainScene.SceneTransition(targetLevel)
