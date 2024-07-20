extends State

@export var swingSpeed: float = 800
@export var weaponOrigin: Vector2 =  Vector2(0, -8)
@export var weaponOffset: float = 4

var weapon: Node2D
var weaponSprite: Sprite2D
var direction: String

func Enter():
	super()
	weapon = parentNode.get_node("Sword")
	direction = get_parent().direction
	var animatedSprite = "attack_" + direction
	weaponSprite = weapon.get_node("Sprite2D")
	SetSwordTransform()
	ToggleWeapon(true)

	animation.play(animatedSprite)

func Exit():
	ToggleWeapon(false)
	super()


func Update(delta):
	if(!animation.is_playing()):
		Transition("Idle")
		return
	
	SwingSword(delta)
	

func SetSwordTransform():
	if direction == "down":
		weapon.position = weaponOrigin + Vector2(0, weaponOffset)
		weaponSprite.rotation = PI + (PI/2)
	if direction == "up":
		weapon.position = weaponOrigin + Vector2(0, -weaponOffset)
		weaponSprite.rotation = PI/2
	if direction == "right":
		weapon.position = weaponOrigin + Vector2(weaponOffset, 0)
		weaponSprite.rotation = PI
	if direction == "left":
		weapon.position = weaponOrigin + Vector2(-weaponOffset, 0)
		weaponSprite.rotation = 0

func SwingSword(delta):
	weaponSprite.rotation_degrees -= delta * swingSpeed
	
	

func ToggleWeapon(isActive: bool):
	weaponSprite.visible = isActive
	weapon.get_node("Sprite2D/SwordBox/CollisionShape2D").disabled = !isActive
