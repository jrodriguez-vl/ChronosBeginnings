extends CharacterBody2D
class_name Player

@export var weapon: Node2D
@export var knockbackDamping: float = 1000
@export var knockbackResistance: float = 0

var healthBar: BaseBar
var expBar: BaseBar
var healthComponent: HealthComponent

var movementAxis: Vector2 = Vector2.ZERO
var currentKnockback: Vector2 = Vector2.ZERO

signal hit

const WALK_UP = "walk_up"
const WALK_DOWN = "walk_down"
const WALK_LEFT = "walk_left"
const WALK_RIGHT = "walk_right"

const ROLL_UP = "roll_up"
const ROLL_DOWN = "roll_down"
const ROLL_LEFT = "roll_left"
const ROLL_RIGHT = "roll_right"

# Called when the node enters the scene tree for the first time.
func _ready():
	healthBar = get_node("PlayerGui/HealthBar")
	expBar = get_node("PlayerGui/ExpBar")
	healthComponent = get_node("HurtBox")

	healthBar.Init(healthComponent.health, healthComponent.health)

func _physics_process(delta):
	currentKnockback = currentKnockback.move_toward(Vector2.ZERO, knockbackDamping * delta)
	velocity = currentKnockback
	move_and_slide()

func _on_hurt_box_knockback(knockbackForce: float, knockbackDirection: Vector2):
	var force = max(knockbackForce - knockbackResistance, 0)
	currentKnockback = force * knockbackDirection

func _on_hurt_box_damaged(health: float):
	healthBar.UpdateCurrent(health)
