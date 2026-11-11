extends Node

var day := 0
var quests_per_day := 3

func start_new_day() -> void:
	
	day += 1
	QuestManager.update_available_quests(quests_per_day)
