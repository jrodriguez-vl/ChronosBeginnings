extends Node
class_name BaseLevel

@export_file var nextLevel: String
@export var monstersToSpawn: int = 5

@onready var stairs: Stairs = preload("res://Scenes/Accessory/Stairs.tscn").instantiate()
@onready var pause: Node2D = preload("res://Scenes/GameManagement/PauseScene.tscn").instantiate()
@onready var monsters: Array[BaseEnemy]

var monstersKilled = 0

func _ready() -> void:
	if !Global.player:
		return

	var path: Path2D = $Path2D
	var pathFollow: PathFollow2D

	stairs.nextLevel = nextLevel

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
		var monsterInstance = load(monster).instantiate()
		monsters.append(monsterInstance)
		monsterInstance.global_position = pathFollow.global_position
		add_child(monsterInstance)

		toTake+=1

	
	monsters.pick_random().MonsterDeath.connect(SpawnStaircase)
		

func SpawnStaircase(monsterPosition: Vector2) -> void:
	stairs.global_position = monsterPosition
	add_child(stairs)
