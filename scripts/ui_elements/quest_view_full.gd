extends QuestView

signal on_close_button_pressed

func _ready() -> void:
	title_label = %QuestTitle
	description_label = %QuestDescription
	deadline_label = %DeadlineLabel


func _on_close_button_pressed() -> void:
	on_close_button_pressed.emit()
