extends Node2D
class_name MainScene

@export var startLevel: PackedScene

var levelInstance: Node2D


func UnloadLevel():
	if (is_instance_valid(levelInstance)):
		print('deleting scene')
		levelInstance.queue_free()
	levelInstance = null

func LoadLevel(sceneName: String) -> void:
	print('loading ', sceneName)
	UnloadLevel()
	var level = load(sceneName).instantiate()

	get_tree().root.add_child(level)
	levelInstance = level
		
func SceneTransition(sceneName: String) -> void:
	add_child(Global.loadingAnimationPlayer)

	var animPlayer = Global.loadingAnimationPlayer.get_node("AnimationPlayer") as AnimationPlayer
	animPlayer.play("fade_to_black")
	await animPlayer.animation_finished

	LoadLevel(sceneName)
	animPlayer.play("fade_from_black")
	await animPlayer.animation_finished

	remove_child(Global.loadingAnimationPlayer)
