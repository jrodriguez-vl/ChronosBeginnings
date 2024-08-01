extends Area2D
class_name HealthComponent

signal Died
signal Knockback
signal Damaged

@export var MAX_HEALTH := 10.0
@export var knockbackResistance = 0
@export var canBeKnockedBack = true
@export var invulnerabilityTime: float = .1
@export var audio: AudioStreamPlayer2D

@onready var damageFloaty = preload("res://Scenes/Accessory/DamageNumber.tscn")
@onready var health : float = MAX_HEALTH

var parent: CharacterBody2D
var invulTimer: Timer

func _ready():
	invulTimer = get_node("InvulTimer")
	invulTimer.wait_time = invulnerabilityTime

func _process(delta):
	pass

func TakeDamage(dmg: float, knockbackForce: float, knockbackDirection: Vector2):
	if audio:
		audio.play()

	if !invulTimer.is_stopped():
		return 
	
	invulTimer.start()

	if health == 0:
		return

	health = clampf(health - dmg, 0, health)

	var num = damageFloaty.instantiate()
	num.SetDamage(dmg)
	add_child(num)
	
	Knockback.emit(knockbackForce, knockbackDirection)
	Damaged.emit(health)

	if(health == 0):
		Died.emit()
	
