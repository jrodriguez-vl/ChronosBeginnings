extends Node2D
class_name ExpDrop

var speed: float = 50
var speedMagnifier: float = 1.0269
var maxSpeed: int = 200
var expAmount: int = 5

var moveTowardsPlayer = false
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var area: Area2D = $Area2D


func _process(delta: float) -> void:
	if moveTowardsPlayer && Global.player:
		var movement = area.global_position.direction_to(Global.player.global_position) * minf(speed, maxSpeed)
		global_position += movement * delta
		speed = speed * speedMagnifier

func _on_area_2d_area_entered(area: Area2D) -> void:
	var component = area.get_parent().get_node("LevelComponent")

	if area.collision_layer == 32:
		animation.play('magnetized')
		await animation.animation_finished
		moveTowardsPlayer = true

	elif component is LevelupComponent:
		component.AddExp(expAmount)
		queue_free()
