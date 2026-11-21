class_name NewQuestView extends Control

@onready var new_quest_info_panel := %NewQuestInfoPanel
@onready var person := %Person
var quest : Quest
var _updating := false

func _on_quest_answered() -> void:
	try_update_quest()

func try_update_quest() -> bool:
	if _updating:
		return false

	_updating = true
	new_quest_info_panel.set_interactive(false)
	new_quest_info_panel.modulate = Color.TRANSPARENT
	person.modulate = Color.TRANSPARENT

	await get_tree().create_timer(0.5).timeout

	quest = QuestManager.take_available()
	if quest != null:
		new_quest_info_panel.fill(quest)
		var appear_tween := create_tween().set_parallel()
		appear_tween.tween_property(new_quest_info_panel, "modulate", Color.WHITE, 1.0)
		appear_tween.tween_property(person, "modulate", Color.WHITE, 1.0)
		await appear_tween.finished
		new_quest_info_panel.set_interactive(true)

	_updating = false
	return quest != null
