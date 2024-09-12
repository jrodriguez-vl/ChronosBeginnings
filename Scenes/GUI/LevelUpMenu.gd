extends Control
class_name LevelUpMenu

var new_points: int = 5

@onready var damage_row: LevelUpMenuRow = %DamageRow
@onready var hp_row: LevelUpMenuRow = %HPRow

@onready var pointsLeftLabel: Label = %PointsLeftLabel
@onready var player: Player = get_tree().get_first_node_in_group('Player')

var player_stats: Dictionary
var stats_to_add: Dictionary

var points_remaining: int:
	get:
		return new_points - _sum_stats(stats_to_add)

var is_add_disabled: bool:
	get:
		return points_remaining <= 0

var is_subtract_disabled: bool:
	get:
		return points_remaining >= new_points

func _ready() -> void:
	player_stats = player._stats.duplicate()
	for key in player_stats:
		stats_to_add[key] = 0

	_prepare_row(damage_row, Player.StatType.DAMAGE)
	_prepare_row(hp_row, Player.StatType.HP)

	_update_rows()

func _prepare_row(row: LevelUpMenuRow, stat_to_increase: Player.StatType):
	row.stat_type = stat_to_increase
	row.stat_added.connect(_on_row_stat_increased.bind(row))
	row.stat_subtracted.connect(_on_row_stat_decreased.bind(row))

	_update_row(row)
	
func _update_rows():
	_update_row(hp_row)
	_update_row(damage_row)
	pointsLeftLabel.text = str(points_remaining)

func _update_row(row: LevelUpMenuRow, point_added: int = 0):
	row.current_stat_label.text = str(player_stats[row.stat_type] + stats_to_add[row.stat_type])
	row.to_add_label.text = str(stats_to_add[row.stat_type])
	row.disabled_add = is_add_disabled
	row.disabled_subtract = is_subtract_disabled || row.to_add_label.text == '0'

func _sum_stats(stats_dict: Dictionary):
	var sum = 0
	for key in stats_dict:
		sum += stats_dict[key]
	return sum

func _on_row_stat_increased(row: LevelUpMenuRow) -> void:
	stats_to_add[row.stat_type] += 1
	_update_rows()

func _on_row_stat_decreased(row: LevelUpMenuRow) -> void:
	stats_to_add[row.stat_type] -= 1
	_update_rows()
