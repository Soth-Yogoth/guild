class_name QuestView extends Control

var title_label : RichTextLabel
var description_label : RichTextLabel
var deadline_label : RichTextLabel

var quest : Quest

func fill(quest: Quest) -> void:
	
	self.quest = quest
	
	title_label.text = quest.title
	description_label.text = quest.description
	deadline_label.text = "Осталось " + str(quest.deadline) + " дня"
	
