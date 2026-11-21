extends PanelContainer

var quest: Quest
var _interactive := false

signal quest_accepted
signal quest_declined

func _ready() -> void:
	set_interactive(false)

func set_interactive(enabled: bool) -> void:
	_interactive = enabled
	mouse_behavior_recursive = MOUSE_BEHAVIOR_INHERITED if enabled else MOUSE_BEHAVIOR_DISABLED
	focus_behavior_recursive = FOCUS_BEHAVIOR_INHERITED if enabled else FOCUS_BEHAVIOR_DISABLED

func fill(quest: Quest) -> void:
	
	self.quest = quest
	
	%Title.text = quest.title
	%QuestDescription.text = quest.description
	%Deadline.text = "Срок: " + str(quest.deadline) + " дня"
	%RewardText.text = "Награда: " + str(quest.reward)
	
	%QuestDescription.start_animation()


func _on_accept() -> void:
	var answered_quest := _take_quest()
	if answered_quest == null:
		return

	QuestManager.accept_quest(answered_quest)
	quest_accepted.emit()

func _on_decline() -> void:
	if _take_quest() == null:
		return

	quest_declined.emit()

func _take_quest() -> Quest:
	if not _interactive or quest == null:
		return null

	var answered_quest := quest
	quest = null
	set_interactive(false)
	return answered_quest
