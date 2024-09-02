extends Node2D

@export var nextLevel: PackedScene
@export var nextLevel2: PackedScene
@export_file var targetLevel: String

func _ready() -> void:
	print(targetLevel)

func _on_static_body_2d_area_entered(area: Area2D) -> void:
	Global.mainScene.SceneTransition(targetLevel)
