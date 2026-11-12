extends Control

@onready var quest_view := %QuestView as QuestView
@onready var new_quest_view := %NewQuestViewContainer

func _can_drop_data(pos, data) -> bool:
	print("can_drop")
	return data is Quest
	
func _drop_data(pos, data) -> void:
	
	print("drop_start")
	
	new_quest_view.hide()
	quest_view.show()
	quest_view.fill(data)
	
	print("drop_end")

func _on_quest_view_close_button_pressed() -> void:
	
	quest_view.hide()
	new_quest_view.show()
