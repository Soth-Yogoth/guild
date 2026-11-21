extends Control

@onready var quest_info_panel := %QuestView as QuestView
@onready var new_quest_info_panel := %NewQuestView

@onready var current_workspace := new_quest_info_panel

func _ready() -> void:
	
	UiManager.quest_selected.connect(_show_quest)

func _can_drop_data(pos, data) -> bool:

	return data is Quest
	
func _drop_data(pos, data) -> void:
	
	_show_quest(data)

func _on_quest_info_closed() -> void:
	
	current_workspace.show()
	quest_info_panel.hide()
	
	QuestManager.set_current_quest(null)
	
func _show_quest(quest: Quest) -> void:
	
	current_workspace.hide()
	quest_info_panel.show()
	quest_info_panel.fill(quest)
	QuestManager.set_current_quest(quest)
	
