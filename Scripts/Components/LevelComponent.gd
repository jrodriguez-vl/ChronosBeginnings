extends Node2D
class_name LevelComponent

signal LevelUp

@export var expIncrement: int

var currentLevel: int
var currentExp: int
var expToLevel: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentLevel = 1
	expToLevel += expIncrement

func _process(delta: float) -> void:
	pass

func AddExp(exp: int):
	currentExp += exp
	print(currentExp)

	if currentExp >= expToLevel:
		currentLevel+=1
		expToLevel+=expIncrement
		LevelUp.emit()
