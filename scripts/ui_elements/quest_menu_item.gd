class_name QuestMenuItem extends Control

var title_label : RichTextLabel
var description_label : RichTextLabel
var deadline_label : RichTextLabel

func _ready() -> void:
	title_label = %TitleLabel
	description_label = %ContentLabel
	deadline_label = %DeadlineLabel

func fill(quest: Quest) -> void:
	
	title_label.text = quest.title
	description_label.text = quest.description
	deadline_label.text = "Осталось " + str(quest.deadline) + " дня"
