extends Node2D

@export var nextLevel: PackedScene

func _on_static_body_2d_area_entered(area: Area2D) -> void:
	Global.mainScene.LoadLevel(nextLevel.resource_path)
