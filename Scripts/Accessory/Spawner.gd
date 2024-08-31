extends Node2D

@export var enemy: Array[PackedScene]
@export var maxObjects: int = 5
@export var burstSpawn: int = 1
@export var spawnCooldownSeconds: float = 1
@export var spawnRadius: float = 100
@export var spawnReference: Node2D

var timeSinceSpawn = 0
var randDirs = [-1,1]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawnRandomRadius(delta: float) -> void:
	if self.get_child_count() < maxObjects && timeSinceSpawn > spawnCooldownSeconds:
		var numberToSpawn = burstSpawn
		while(numberToSpawn > 0):
			var toSpawn = enemy.pick_random()
			var obj = toSpawn.instantiate()
			var randX = randDirs.pick_random() * spawnRadius
			var randY = randDirs.pick_random() * spawnRadius

			obj.global_position.x += randX 
			obj.global_position.y += randY

			obj.global_position += spawnReference.global_position

			add_child(obj)
			numberToSpawn-=1
		
		timeSinceSpawn = 0

	timeSinceSpawn += delta
