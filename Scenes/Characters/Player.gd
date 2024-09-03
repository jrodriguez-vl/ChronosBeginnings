extends CharacterBody2D
class_name Player

@export var weapon: Node2D
@export var knockbackDamping: float = 1000
@export var knockbackResistance: float = 0

@export var hp = 10
@export var special = 10
@export var damage = 1
@export var defense = 0
@export var luck = 1

var healthBar: BaseBar
var expBar: BaseBar
var levelText: RichTextLabel
var healthComponent: HealthComponent
var levelComponent: LevelComponent

var movementAxis: Vector2 = Vector2.ZERO
var currentKnockback: Vector2 = Vector2.ZERO
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

var active: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	healthBar = get_node("PlayerGUI/HealthBar")
	expBar = get_node("PlayerGUI/ExpBar")
	healthComponent = get_node("HurtBox")
	levelText = get_node("PlayerGUI/PlayerLevel")
	levelComponent = get_node("LevelComponent")

	healthComponent.health = hp
	healthComponent.MAX_HEALTH = hp
	healthComponent.Died.connect(PlayerDeath)

	SetLevel(levelComponent.currentLevel)
	healthBar.Init(healthComponent.health, healthComponent.health)

func SetLevel(level: int):
	levelText.text = str(level)

func SetActive(enable: bool):
	self.visible = enable
	Global.playerGui.visible = enable

func _physics_process(delta):
	if !active:
		return
	currentKnockback = currentKnockback.move_toward(Vector2.ZERO, knockbackDamping * delta)
	velocity = currentKnockback
	move_and_slide()

func _on_hurt_box_knockback(knockbackForce: float, knockbackDirection: Vector2):
	var force = max(knockbackForce - knockbackResistance, 0)
	currentKnockback = force * knockbackDirection

func _on_hurt_box_damaged(health: float):
	healthBar.UpdateCurrent(health)


func _on_level_component_level_up() -> void:
	#TODO: Level up sound & maybe animation?
	#TODO: Stat allocations via gui or static depending on class
	SetLevel(levelComponent.currentLevel)
	hp+=5
	damage+=5
	healthComponent.health = healthComponent.MAX_HEALTH
	healthBar.UpdateCurrent(healthComponent.health)
	

func PlayerDeath():
	#TODO: Play death sound
	active = false
	animationPlayer.play('Death')

	get_node("StateMachine").queue_free()

	await animationPlayer.animation_finished

	Global.mainScene.SceneTransition("res://Scenes/Levels/Title.tscn")

	queue_free()
