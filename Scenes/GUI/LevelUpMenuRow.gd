extends HBoxContainer
class_name LevelUpMenuRow

signal stat_added
signal stat_subtracted

@onready var current_stat_label: Label = %CurrentStatLabel
@onready var to_add_label: Label = %ToAddLabel
@onready var minus_button: Button = %MinusButton
@onready var plus_button: Button = %PlusButton

var disabled_add: bool:
	set(value):
		plus_button.disabled = value

var disabled_subtract:
	set(value):
		minus_button.disabled = value

var stat_type: Player.StatType

func _ready() -> void:
	plus_button.pressed.connect(_add_to_stat)
	minus_button.pressed.connect(_sub_from_stat)

func _add_to_stat() -> void:
	stat_added.emit()

func _sub_from_stat() -> void:
	stat_subtracted.emit()
