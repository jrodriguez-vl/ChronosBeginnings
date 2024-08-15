extends CharacterBody2D
class_name BaseEnemy

@export var knockbackResistance: float = 0
@export var knockbackDamping: float = 1000
@export var audio: AudioStreamPlayer2D

var currentKnockback: Vector2 = Vector2.ZERO

@onready var animPlayer: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	var children = get_children()
	for child in children:
		if child is HealthComponent:
			child.Died.connect(die)
			child.Knockback.connect(knockback)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	#TODO: move the velocity from the enemy states to here to apply them all in one place
	currentKnockback = currentKnockback.move_toward(Vector2.ZERO, knockbackDamping * delta)
	velocity = currentKnockback
	print(currentKnockback)
	move_and_slide()

func die():
	get_node("StateMachine").queue_free()
	get_node("DamageArea").queue_free()
	get_node("HurtBox").queue_free()

	animPlayer.play("Death")
	await animPlayer.animation_finished
	queue_free()

func knockback(knockbackForce: float, knockbackDirection: Vector2):
	var force = max(knockbackForce - knockbackResistance, 0)
	currentKnockback = force * knockbackDirection
