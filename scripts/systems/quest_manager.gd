extends Node

signal on_quest_accepted(quest: Quest)
signal on_quest_started(quest: Quest)
signal on_quest_finished(quest: Quest)
signal on_quest_abandoned(quest: Quest)

var quest_database := load("res://resources/quest_database.tres") as QuestDatabase

var available_quests: Array[Quest]
var accepted_quests: Array[Quest]
var process_quests: Array[Quest]
var completed_quests: Array[Quest]

var archive: Array[Quest]

func update_available_quests(count: int) -> void:
	
	available_quests.clear()
	
	for i in range(count):
		available_quests.append(Quest.new(quest_database.quests[i]))
	available_quests.shuffle()
		
func take_available() -> Quest:
	return available_quests.pop_back()

func generate_quest() -> Quest:
	
	var quest = quest_database.quests.pick_random()
	return Quest.new(quest)
	
func accept_quest(quest: Quest) -> void:
	print("Manager accepted: ", quest)
	accepted_quests.append(quest)
	on_quest_accepted.emit(quest)
	
func get_accepted_quests() -> Array[Quest]: 
	return accepted_quests
