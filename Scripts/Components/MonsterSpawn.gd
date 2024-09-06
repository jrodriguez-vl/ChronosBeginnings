extends Path2D
class_name MonsterSpawn

@export var monstersToSpawn: int = 5

@onready var monsters: Array[BaseEnemy]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	var pathFollow = get_node("PathFollow2D")

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
	
	monsters.pick_random().MonsterDeath.connect(Progress)

func Progress(progressSpawnLocation: Vector2):
	Events.ProgressLevel.emit(progressSpawnLocation)
	
