extends Node2D

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		var isPausing = !get_tree().paused
		TogglePause(isPausing)
		

func TogglePause(isPausing: bool) -> void:
		if isPausing:
			get_tree().paused = isPausing
			$AnimationPlayer.play('pause')
			await $AnimationPlayer.animation_finished
		else:
			$AnimationPlayer.play('unpause')
			await $AnimationPlayer.animation_finished
			get_tree().paused = isPausing
	
