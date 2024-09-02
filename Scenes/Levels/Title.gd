extends Node2D


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		StartGame()

func _on_button_pressed() -> void:
	StartGame()

func StartGame() -> void:
	Global.InitGame()
	Global.mainScene.SceneTransition("res://Scenes/Levels/Cata1.tscn")
	queue_free()
