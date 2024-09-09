extends Path2D
class_name MonsterSpawnEndless


var amountToSpawn = 10
var spawned = 0
var pathFollow: PathFollow2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pathFollow = get_node("PathFollow2D")
	

func _process(delta) -> void:
	if spawned < amountToSpawn:
		pathFollow.progress_ratio += randf_range(0.0,1.0)
		var monster = Global.monsterRoster.pick_random()
		var monsterInstance = load(monster).instantiate()
		monsterInstance.global_position = pathFollow.global_position
		add_child(monsterInstance)

		spawned+=1
	


func _on_timer_timeout() -> void:
	spawned = 0
