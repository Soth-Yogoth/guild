extends Control

@onready var container := %QuestItemsContainer
const quest_menu_item_scene := preload("res://scenes/quest_menu_item.tscn")

func _ready() -> void:
	
	var quests = QuestManager.get_accepted_quests()
	QuestManager.on_quest_accepted.connect(add_quest)
	
	for quest in quests:
		add_quest(quest)
		
func add_quest(quest) -> void:
	
	var quest_menu_item := quest_menu_item_scene.instantiate() as QuestMenuItem
	
	container.add_child(quest_menu_item)
	quest_menu_item.fill(quest)
