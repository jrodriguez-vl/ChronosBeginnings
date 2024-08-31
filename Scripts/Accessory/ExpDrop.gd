extends Node
class_name ExpDrop

var expAmount: int = 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	var component = area.get_parent().get_node("LevelComponent")

	if component is LevelComponent:
		component.AddExp(expAmount)
		queue_free()
