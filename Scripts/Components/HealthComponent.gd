extends Area2D
class_name HealthComponent

signal Died
signal Knockback

@export var MAX_HEALTH := 10.0
@export var knockbackResistance = 0
@export var canBeKnockedBack = true

@onready var damageFloaty = preload("res://Scenes/Accessory/DamageNumber.tscn")
@onready var health : float = MAX_HEALTH

var parent: CharacterBody2D

func _ready():
	pass

func _process(delta):
	pass

func TakeDamage(dmg: float, knockbackForce: float, knockbackDirection: Vector2):
	if health == 0:
		return

	health = clampf(health - dmg, 0, health)

	var num = damageFloaty.instantiate()
	num.SetDamage(dmg)
	add_child(num)
	
	Knockback.emit(knockbackForce, knockbackDirection)

	if(health == 0):
		Died.emit()
	
