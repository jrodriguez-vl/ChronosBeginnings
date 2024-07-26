extends Node
class_name DamageNumber

@export var label: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Damage")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !$AnimationPlayer.is_playing():
		queue_free()

func SetDamage(dmg: float):
	label.text = str(dmg)
