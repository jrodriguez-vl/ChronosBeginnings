extends Node2D
class_name Player

@export var weapon: Node2D

signal hit

const WALK_UP = "walk_up"
const WALK_DOWN = "walk_down"
const WALK_LEFT = "walk_left"
const WALK_RIGHT = "walk_right"

const ROLL_UP = "roll_up"
const ROLL_DOWN = "roll_down"
const ROLL_LEFT = "roll_left"
const ROLL_RIGHT = "roll_right"

func start(pos):
	position = pos
	show()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
