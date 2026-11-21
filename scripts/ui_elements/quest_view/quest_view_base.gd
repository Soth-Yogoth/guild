class_name QuestView extends Control

var title_label : RichTextLabel
var description_label : RichTextLabel
var deadline_label : RichTextLabel
@onready var status_label := get_node_or_null("%StatusLabel") as Label

var quest : Quest

func fill(quest: Quest) -> void:
	
	if quest == null:
		print("quest is null")
		return
	
	if self.quest != quest:
		if self.quest != null:
			self.quest.progress_changed.disconnect(_refresh_quest_state)
		self.quest = quest
		quest.progress_changed.connect(_refresh_quest_state)
	
	title_label.text = quest.title
	description_label.text = quest.description
	deadline_label.text = "Осталось " + str(quest.deadline) + " дня"
	_refresh_quest_state()

func _refresh_quest_state() -> void:
	if status_label == null:
		return

	deadline_label.visible = quest.status == Quest.ACCEPTED
	match quest.status:
		Quest.ACCEPTED:
			status_label.text = "Принято"
		Quest.IN_PROGRESS:
			status_label.text = "Выполняется"
		Quest.COMPLETED:
			status_label.text = "Завершено"
