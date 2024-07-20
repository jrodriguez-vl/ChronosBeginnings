extends State

var weapon: BaseWeapon
var direction: String

func Enter():
	super()
	weapon = parentNode.get_node("Sword")
	direction = get_parent().direction
	var animatedSprite = "attack_" + direction
	weapon.SetWeaponTransform(direction)
	weapon.ToggleWeapon(true)

	animation.play(animatedSprite)

func Exit():
	weapon.ToggleWeapon(false)
	super()


func Update(delta):
	if(!animation.is_playing()):
		Transition("Idle")
		return
	
	weapon.SwingWeapon(delta)
	

