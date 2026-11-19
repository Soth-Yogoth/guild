extends PanelContainer

var quest

signal quest_accepted
signal quest_declined
	
func fill(quest: Quest) -> void:
	
	self.quest = quest
	
	%Title.text = quest.title
	%QuestDescription.text = quest.description
	%Deadline.text = "Срок: " + str(quest.deadline) + " дня"
	%RewardText.text = "Награда: " + str(quest.reward)
	
	%QuestDescription.start_animation()


func _on_accept() -> void:
	
	QuestManager.accept_quest(quest)
	quest_accepted.emit()

func _on_decline() -> void:
	quest_declined.emit()
