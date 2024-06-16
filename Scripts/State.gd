extends Node
class_name State

signal Transitioned

var PlayerNode : Node2D
var animation : AnimatedSprite2D
var state_machine : StateMachine

func Transition(newState: String):
	Transitioned.emit(self, newState)

func Enter():
	PlayerNode = self.get_parent().PlayerNode
	animation = PlayerNode.get_node("AnimatedSprite2D")
	state_machine = self.get_parent()

func Exit():
	pass
	
func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	pass
