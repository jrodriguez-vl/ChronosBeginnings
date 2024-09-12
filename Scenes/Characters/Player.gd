extends CharacterBody2D
class_name Player

@export var weapon: Node2D
@export var knockbackDamping: float = 1000
@export var knockbackResistance: float = 0

var hp: 
	get: return _stats[StatType.HP]
var special: 
	get: return _stats[StatType.SPECIAL]
var damage: 
	get: return _stats[StatType.DAMAGE]
var defense: 
	get: return _stats[StatType.DEFENSE]
var luck: 
	get: return _stats[StatType.LUCK]


enum StatType { HP, SPECIAL, DAMAGE, DEFENSE, LUCK }

var _stats: Dictionary = {
	StatType.HP: 10,
	StatType.SPECIAL: 10,
	StatType.DAMAGE: 100,
	StatType.DEFENSE: 0,
	StatType.LUCK: 1,
}

var healthBar: BaseBar
var expBar: BaseBar
var levelText: RichTextLabel
var healthComponent: HealthComponent
var levelupComponent: LevelupComponent

var movementAxis: Vector2 = Vector2.ZERO
var currentKnockback: Vector2 = Vector2.ZERO
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var LevelUpNotification: PackedScene = preload('res://Scenes/Accessory/LevelUpNotification.tscn')

var active: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	healthBar = get_node("PlayerGUI/HealthBar")
	expBar = get_node("PlayerGUI/ExpBar")
	healthComponent = get_node("HurtBox")
	levelText = get_node("PlayerGUI/PlayerLevel")
	levelupComponent = get_node("LevelComponent")

	healthComponent.health = hp
	healthComponent.MAX_HEALTH = hp
	healthComponent.Died.connect(PlayerDeath)

	SetLevel(levelupComponent.currentLevel)
	healthBar.Init(healthComponent.health, healthComponent.health)


func set_stats(updated_stats: Dictionary):
	_stats = updated_stats
	

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
	var levNot = LevelUpNotification.instantiate()
	add_child(levNot)

	#TODO: Stat allocations via gui or static depending on class
	SetLevel(levelupComponent.currentLevel)

	hp+=5
	damage+=5
	healthComponent.health = healthComponent.MAX_HEALTH
	healthBar.UpdateCurrent(healthComponent.health)
	
func PlayerDeath():
	#TODO: Play death sound
	$HurtBox.queue_free()
	$CollisionShape2D.queue_free()
	$Magnet.queue_free()
	active = false
	animationPlayer.play('Death')



	get_node("StateMachine").queue_free()

	await animationPlayer.animation_finished

	Global.mainScene.SceneTransition("res://Scenes/Levels/Title.tscn")

	queue_free()
