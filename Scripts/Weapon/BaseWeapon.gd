extends Node2D

class_name BaseWeapon

@export var swingSpeed: float = 800
@export var weaponOrigin: Vector2 =  Vector2(0, -8)
@export var weaponOffset: float = 4
@export var weaponDamage: int = 1
@export var weaponDamageModifier: int = 4
@export var knockbackForce: float = 200
@export var audio: AudioStreamPlayer2D

var weaponSprite: Sprite2D
var swingAxis: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	weaponSprite = get_node("Sprite2D")
	ToggleWeapon(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func SetWeaponTransform(direction: String):
	if direction == "down":
		position = weaponOrigin + Vector2(0, weaponOffset)
		weaponSprite.rotation = PI + (PI/2)
	if direction == "up":
		position = weaponOrigin + Vector2(0, -weaponOffset)
		weaponSprite.rotation = PI/2
	if direction == "right":
		position = weaponOrigin + Vector2(weaponOffset, 0)
		weaponSprite.rotation = PI
	if direction == "left":
		position = weaponOrigin + Vector2(-weaponOffset, 0)
		weaponSprite.rotation = 0

func SwingWeapon(delta):
	weaponSprite.rotation_degrees -= delta * swingSpeed
	
func ToggleWeapon(isActive: bool):
	if(isActive):
		audio.play()
	weaponSprite.visible = isActive
	get_node("Sprite2D/SwordBox/CollisionShape2D").disabled = !isActive


func _on_sword_box_area_entered(area):
	if area is HealthComponent:
		var damage = randi_range(weaponDamage, weaponDamageModifier + weaponDamage)
		damage = damage + Global.player.damage
		var pos = global_position.direction_to(area.global_position)
		area.TakeDamage(damage, knockbackForce, pos)
