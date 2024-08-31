extends Node

@onready var mainScene: MainScene
@onready var player: Player = preload("res://Scenes/Characters/Player.tscn").instantiate()
@onready var weapon: BaseWeapon = preload("res://Scenes/Weapons/Sword.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = preload("res://Scenes/Characters/Player.tscn").instantiate()
	weapon = preload("res://Scenes/Weapons/Sword.tscn").instantiate()
	player.weapon = weapon
	print("loaded global")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
