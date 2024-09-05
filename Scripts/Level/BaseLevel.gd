extends Node
class_name BaseLevel

@export_file var nextLevel: String
@export var monstersToSpawn: int = 5

@onready var stairs: Stairs = preload("res://Scenes/Accessory/Stairs.tscn").instantiate()
@onready var pause: Node2D = preload("res://Scenes/GameManagement/PauseScene.tscn").instantiate()
@onready var monsters: Array[BaseEnemy]

var monstersKilled = 0
var canPause = false

func _ready() -> void:
	if !Global.player:
		return

	stairs.level = self
	stairs.nextLevel = nextLevel
	
	pause.level = self
	add_child(pause)

	var path: Path2D = $Path2D
	var pathFollow: PathFollow2D

	var playerPosition = get_node('Marker2D')
	pathFollow = path.get_node("PathFollow2D")

	if(playerPosition):
		var cam = Camera2D.new()

		Global.player.global_position = playerPosition.global_position
		add_child(cam)

		Global.player.get_node("RemoteTransform2D").remote_path = cam.get_path()
		Global.player.SetActive(true)

	
	var toTake = 0
	while toTake < monstersToSpawn:
		pathFollow.progress_ratio += randf_range(0.0,1.0/monstersToSpawn)
		var monster = Global.monsterRoster.pick_random()
		var monsterInstance = load(monster).instantiate()
		monsters.append(monsterInstance)
		monsterInstance.global_position = pathFollow.global_position
		add_child(monsterInstance)

		toTake+=1
		pathFollow.progress_ratio = 1.0/monstersToSpawn * toTake

	
	monsters.pick_random().MonsterDeath.connect(SpawnStaircase)
	canPause = true
		

func SpawnStaircase(monsterPosition: Vector2) -> void:
	stairs.global_position = monsterPosition
	add_child(stairs)
