extends Area2D

@export var damage: float = 5
@export var knockback: float = 200

func _ready():
	pass # Replace with function body.


func _process(delta):
	pass


func _on_area_entered(area):
	if area is HealthComponent:
		var pos = global_position.direction_to(area.global_position)
		area.TakeDamage(damage, knockback, pos)
