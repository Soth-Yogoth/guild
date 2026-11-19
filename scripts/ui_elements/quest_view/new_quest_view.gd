class_name NewQuestView extends Control

@onready var new_quest_info_panel := %NewQuestInfoPanel
@onready var person := %Person
var quest : Quest

func _on_quest_answered() -> void:
	
	new_quest_info_panel.modulate = Color.TRANSPARENT
	person.modulate = Color.TRANSPARENT
	
	try_update_quest()
	
func try_update_quest() -> bool:
	
	await get_tree().create_timer(0.5).timeout
	
	quest = QuestManager.take_available()
	if quest == null: 
		return false
		
	new_quest_info_panel.fill(quest)
	
	var quest_tween := appear(new_quest_info_panel, 1)
	var person_tween := appear(person, 1)
	
	await quest_tween.finished
	await person_tween.finished
	
	return true
	
func shade(object: Control, time: int) -> Tween:
	
	var shade_tween = get_tree().create_tween()
	shade_tween.tween_property(object, "modulate", Color.TRANSPARENT, time)
	
	return shade_tween
	
func appear(object: Control, time: int) -> Tween:
	
	var shade_tween = get_tree().create_tween()
	shade_tween.tween_property(object, "modulate", Color.WHITE, time)
	
	return shade_tween
