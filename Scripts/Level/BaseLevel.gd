extends Node
class_name BaseLevel

@export_file var nextLevel: String
@export var monstersToSpawn: int = 5

@onready var stairs: Stairs = preload("res://Scenes/Accessory/Stairs.tscn").instantiate()
@onready var pause: Node2D = preload("res://Scenes/GameManagement/PauseScene.tscn").instantiate()
@onready var monsters: Array[BaseEnemy]
@onready var path: Path2D = $Path2D
@onready var pathFollow: PathFollow2D

#kill all monsters on floor for staircase to spawn
#there are x number of monsters predefined per floor depending on level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !Global.player:
		return

	var playerPosition = get_node('Marker2D')
	pathFollow = path.get_node("PathFollow2D")

	if(playerPosition):
		var cam = Camera2D.new()

		Global.player.global_position = playerPosition.global_position
		add_child(cam)

		Global.player.get_node("RemoteTransform2D").remote_path = cam.get_path()
		Global.player.SetActive(true)

	add_child(pause)
	
	var toTake = 0
	while toTake < monstersToSpawn:
		pathFollow.progress_ratio += randf_range(0.0,1.0/monstersToSpawn)
		var monster = Global.monsterRoster.pick_random()
		monsters.append(monster)
		var monsterInstance = load(monster).instantiate()
		# var monsterInstance = preload(monster).instantiate()
		monsterInstance.global_position = pathFollow.global_position
		add_child(monsterInstance)

		toTake+=1
		

func _physics_process(delta: float) -> void:
	pass
	
