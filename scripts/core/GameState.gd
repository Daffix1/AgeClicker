extends Node

signal state_changed


const STARTING_POPULATION: int = 3
const MAX_POPULATION: int = 5

const WOOD_PER_LUMBERJACK_PER_SECOND: float = 1.0


var population: int = STARTING_POPULATION
var lumberjack_workers: int = 0

var wood: float = 0.0

var _ui_update_timer: float = 0.0
const UI_UPDATE_INTERVAL: float = 0.1


func _process(delta: float) -> void:
	var wood_rate := get_wood_rate()

	if wood_rate > 0.0:
		wood += wood_rate * delta

	_ui_update_timer += delta

	if _ui_update_timer >= UI_UPDATE_INTERVAL:
		_ui_update_timer = 0.0
		state_changed.emit()


func get_free_workers() -> int:
	return population - lumberjack_workers


func get_wood_rate() -> float:
	return lumberjack_workers * WOOD_PER_LUMBERJACK_PER_SECOND


func assign_lumberjack() -> bool:
	if get_free_workers() <= 0:
		return false

	lumberjack_workers += 1
	state_changed.emit()

	return true


func unassign_lumberjack() -> bool:
	if lumberjack_workers <= 0:
		return false

	lumberjack_workers -= 1
	state_changed.emit()

	return true
