extends PanelContainer

@export_category("Resource")
@export var resource_name: String = "ЕДА"
@export var amount: float = 1250.0
@export var icon: Texture2D

@export_category("Workers")
@export var workers: int = 10
@export var max_workers: int = 10
@export var workers_required: int = 5

@export_category("Purchase")
@export var price: int = 100

@onready var icon_rect: TextureRect = $Margin/Content/Icon
@onready var name_label: Label = $Margin/Content/ResourceInfo/NameLabel
@onready var amount_label: Label = $Margin/Content/ResourceInfo/AmountLabel

@onready var workers_label: Label = $Margin/Content/WorkersInfo/WorkersLabel
@onready var next_worker_label: Label = $Margin/Content/WorkersInfo/NextWorkerLabel

@onready var buy_button: Button = $Margin/Content/BuyButton

func _ready() -> void:
	update_ui()
	
func update_ui() -> void:
	name_label.text = resource_name
	amount_label.text = format_number(amount)

	workers_label.text = "👤 %d/%d" % [workers, max_workers]
	next_worker_label.text = "👤+ НУЖНО: %d" % workers_required

	buy_button.text = "КУПИТЬ\n✊ %s" % format_number(price)

	if icon:
		icon_rect.texture = icon


func format_number(value: float) -> String:
	var number := str(int(value))
	var result := ""
	var counter := 0

	for i in range(number.length() - 1, -1, -1):
		result = number[i] + result
		counter += 1

		if counter % 3 == 0 and i != 0:
			result = " " + result

	return result
