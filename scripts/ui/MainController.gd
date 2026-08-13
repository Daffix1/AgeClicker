extends Control


@onready var population_label: Label = (
	$MarginContainer/MainVBox/Header/PopulationRow/PopulationLabel
)

@onready var wood_amount_label: Label = (
	$MarginContainer/MainVBox/ResourceSection/WoodCard/WoodContent/WoodAmount
)

@onready var wood_rate_label: Label = (
	$MarginContainer/MainVBox/ResourceSection/WoodCard/WoodContent/WoodRate
)

@onready var free_workers_label: Label = (
	$MarginContainer/MainVBox/StatsSection/WorkersStat/WorkersValue
)

@onready var total_production_label: Label = (
	$MarginContainer/MainVBox/StatsSection/ProductionStat/ProductionValue
)

@onready var lumberjack_workers_label: Label = (
	$MarginContainer/MainVBox/ProductionScroll/ProductionList/LumberjackRow/LumberjackContent/LumberjackInfo/WorkersRow/WorkersValue
)

@onready var lumberjack_rate_label: Label = (
	$MarginContainer/MainVBox/ProductionScroll/ProductionList/LumberjackRow/LumberjackContent/LumberjackRate
)

@onready var minus_button: Button = (
	$MarginContainer/MainVBox/ProductionScroll/ProductionList/LumberjackRow/LumberjackContent/LumberjackInfo/WorkersRow/MinusButton
)

@onready var plus_button: Button = (
	$MarginContainer/MainVBox/ProductionScroll/ProductionList/LumberjackRow/LumberjackContent/LumberjackInfo/WorkersRow/PlusButton
)


func _ready() -> void:
	plus_button.pressed.connect(_on_plus_button_pressed)
	minus_button.pressed.connect(_on_minus_button_pressed)

	GameState.state_changed.connect(_refresh_ui)

	_refresh_ui()


func _on_plus_button_pressed() -> void:
	GameState.assign_lumberjack()


func _on_minus_button_pressed() -> void:
	GameState.unassign_lumberjack()


func _refresh_ui() -> void:
	var free_workers := GameState.get_free_workers()
	var wood_rate := GameState.get_wood_rate()

	population_label.text = "👥 %d / %d" % [
		GameState.population,
		GameState.MAX_POPULATION
	]

	free_workers_label.text = str(free_workers)

	lumberjack_workers_label.text = str(
		GameState.lumberjack_workers
	)

	wood_amount_label.text = _format_number(
		GameState.wood
	)

	wood_rate_label.text = "+%s / сек" % (
		_format_number(wood_rate)
	)

	lumberjack_rate_label.text = "+%s / сек" % (
		_format_number(wood_rate)
	)

	total_production_label.text = "+%s / сек" % (
		_format_number(wood_rate)
	)

	plus_button.disabled = free_workers <= 0
	minus_button.disabled = GameState.lumberjack_workers <= 0


func _format_number(value: float) -> String:
	if is_equal_approx(value, round(value)):
		return str(int(round(value)))

	return "%.1f" % value
