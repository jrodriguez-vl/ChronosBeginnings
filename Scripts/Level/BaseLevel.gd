extends Node
class_name BaseLevel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !Global.player:
		return

	var playerPosition = get_node('Marker2D')

	if(playerPosition):
		var cam = Camera2D.new()

		Global.player.global_position = playerPosition.global_position
		add_child(cam)

		Global.player.get_node("RemoteTransform2D").remote_path = cam.get_path()
		Global.player.SetActive(true)
