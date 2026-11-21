extends Control

@onready var new_quest_info_panel := %NewQuestView as NewQuestView
@onready var start_button := %StartDayButton

var _first_day_pending := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	GameManager.start_new_day()
	new_quest_info_panel.offers_exhausted.connect(_on_offers_exhausted)

func _on_button_pressed() -> void:
	
	start_button.hide()
	if not _first_day_pending:
		GameManager.start_new_day()
	_first_day_pending = false
	new_quest_info_panel.try_update_quest()

func _on_offers_exhausted() -> void:
	start_button.text = "Следующий день"
	start_button.show()
