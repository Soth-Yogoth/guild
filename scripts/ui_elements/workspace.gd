extends Control

@onready var quest_info_panel := %QuestView as QuestView
@onready var new_quest_info_panel := %NewQuestView

@onready var last_workspace := new_quest_info_panel
@onready var current_workspace := new_quest_info_panel

func _can_drop_data(pos, data) -> bool:

	return data is Quest
	
func _drop_data(pos, data) -> void:
	
	_set_current_workspace(quest_info_panel)
	quest_info_panel.fill(data)
	
	QuestManager.set_current_quest(data)

func _on_quest_info_closed() -> void:
	
	_set_current_workspace(last_workspace)
	
	QuestManager.set_current_quest(null)
	
func _set_current_workspace(workspace: Control) -> void:
	
	if (current_workspace == workspace): return
	
	last_workspace = current_workspace
	last_workspace.hide()
	
	current_workspace = workspace
	current_workspace.show()
