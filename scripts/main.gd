extends Control

@onready var quest_view := %NewQuestView
@onready var start_button := %StartDayButton
var quest

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	GameManager.start_new_day()
	quest_view.hide()

func _on_button_pressed() -> void:
	
	start_button.hide()
	try_update_quest_view()


func _on_quest_accepted() -> void:
	
	print("Main accepted: ", quest)
	QuestManager.accept_quest(quest)
	
	quest_view.hide()
	try_update_quest_view()

func _on_quest_declined() -> void:
	
	quest_view.hide()
	try_update_quest_view()
	
func try_update_quest_view() -> bool:
	
	quest = QuestManager.take_available()
	print("update info: ", quest)
	if quest == null: return false
	
	quest_view.fill(quest)
	quest_view.show()
	return true
