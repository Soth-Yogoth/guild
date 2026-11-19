extends Control

@onready var new_quest_info_panel := %NewQuestView as NewQuestView
@onready var start_button := %StartDayButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	GameManager.start_new_day()

func _on_button_pressed() -> void:
	
	start_button.hide()
	new_quest_info_panel.try_update_quest()
