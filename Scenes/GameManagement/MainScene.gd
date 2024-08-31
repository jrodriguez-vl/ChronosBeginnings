extends Node2D
class_name MainScene

@export var startLevel: PackedScene

var levelInstance: Node2D
@onready var main2D = $Main2D

func _ready() -> void:
	print('loaded main')
	LoadLevel(startLevel.resource_path)
	Global.mainScene = self
	self.add_child(Global.player)
	Global.player.visible = false


func UnloadLevel():
	if (is_instance_valid(levelInstance)):
		levelInstance.queue_free()
	levelInstance = null

func LoadLevel(sceneName: String) -> void:
	UnloadLevel()
	var res = load(sceneName).instantiate()
	
	main2D.add_child(res)
	levelInstance = res
	var playerPosition = levelInstance.get_node('Marker2D')

	if(playerPosition):
		Global.player.global_position = playerPosition.global_position
		Global.player.visible = true

		var cam = Camera2D.new()
		levelInstance.add_child(cam)
		Global.player.get_node("RemoteTransform2D").remote_path = cam.get_path()
		
