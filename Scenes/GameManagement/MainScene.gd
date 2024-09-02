extends Node2D
class_name MainScene

@export var startLevel: PackedScene

var levelInstance: Node2D
@onready var loadingAnimationPlayer: CanvasLayer = preload("res://Scenes/GUI/LoadingAnimationPlayer.tscn").instantiate()

func _ready() -> void:
	print('loaded main')
	LoadLevel(startLevel.resource_path)
	Global.mainScene = self
	Global.player = preload("res://Scenes/Characters/Player.tscn").instantiate()
	Global.weapon = preload("res://Scenes/Weapons/Sword.tscn").instantiate()
	Global.player.weapon = Global.weapon
	Global.playerGui = Global.player.get_node("PlayerGUI")

	Global.player.SetActive(false)

	add_child(Global.player)


func UnloadLevel():
	if (is_instance_valid(levelInstance)):
		levelInstance.queue_free()
	levelInstance = null

func LoadLevel(sceneName: String) -> void:
	UnloadLevel()
	var level = load(sceneName).instantiate()
	
	add_child(level)
	levelInstance = level
		
func SceneTransition(sceneName: String) -> void:
	print('going to scene transition')
	add_child(loadingAnimationPlayer)
	var animPlayer = loadingAnimationPlayer.get_node("AnimationPlayer") as AnimationPlayer
	animPlayer.play("fade_to_black")
	await animPlayer.animation_finished
	#some anim fade out
	LoadLevel(sceneName)
	#some anim fade in
	animPlayer.play("fade_from_black")
	await animPlayer.animation_finished
	remove_child(loadingAnimationPlayer)
