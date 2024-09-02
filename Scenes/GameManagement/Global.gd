extends Node

var mainScene: MainScene
var player: Player
var weapon: BaseWeapon
var playerGui: CanvasLayer
var loadingAnimationPlayer: CanvasLayer

func _ready() -> void:
	loadingAnimationPlayer = preload("res://Scenes/GUI/LoadingAnimationPlayer.tscn").instantiate()
	mainScene = preload("res://Scenes/GameManagement/MainScene.tscn").instantiate()
	get_tree().root.add_child.call_deferred(mainScene)

func InitGame() -> void:
	player = preload("res://Scenes/Characters/Player.tscn").instantiate()
	weapon = preload("res://Scenes/Weapons/Sword.tscn").instantiate()
	player.weapon = weapon
	playerGui = player.get_node("PlayerGUI")
	player.SetActive(false)

	add_child(player)
