extends Control

@onready var quest_info_panel := %QuestView as QuestView
@onready var new_quest_info_panel := %NewQuestView

func _can_drop_data(pos, data) -> bool:

	return data is Quest
	
func _drop_data(pos, data) -> void:
	
	new_quest_info_panel.hide()
	quest_info_panel.show()
	quest_info_panel.fill(data)

func _on_quest_info_closed() -> void:
	
	quest_info_panel.hide()
	new_quest_info_panel.show()
