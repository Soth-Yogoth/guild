extends PanelContainer

signal quest_accepted
signal quest_declined
	
func fill(quest: Quest) -> void:
	
	$MarginContainer/VBoxContainer/Title.text = quest.title
	$MarginContainer/VBoxContainer/QuestContent.text = quest.description
	$MarginContainer/VBoxContainer/Deadline.text = "Срок: " + str(quest.deadline) + " дня"
	$MarginContainer/VBoxContainer/RewardText.text = "Награда: " + str(quest.reward)
	
	$MarginContainer/VBoxContainer/QuestContent.start_animation()


func _on_accept() -> void:
	quest_accepted.emit()


func _on_decline() -> void:
	quest_declined.emit()
