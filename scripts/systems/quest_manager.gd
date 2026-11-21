extends Node

signal current_quest_changed(quest: Quest)
signal current_party_reorganised(party: Array[Hero])

signal on_quest_accepted(quest: Quest)
signal on_quest_started(quest: Quest)
signal on_quest_finished(quest: Quest)
signal on_quest_abandoned(quest: Quest)

var quest_database := load("res://resources/quest_database.tres") as QuestDatabase

var current_quest: Quest
var current_party: Array[Hero]

var available_quests: Array[Quest]
var accepted_quests: Array[Quest]
var process_quests: Array[Quest]
var completed_quests: Array[Quest]

var archive: Array[Quest]

func set_current_quest(quest: Quest) -> void:
	
	if current_quest == quest:
		return
	current_quest = quest
	current_quest_changed.emit(current_quest)
	
func add_hero_to_party(hero: Hero) -> void:
	if current_quest == null or current_quest.status != Quest.ACCEPTED:
		return
	if hero == null or hero in current_party or is_hero_on_mission(hero):
		return

	current_party.append(hero)
	current_party_reorganised.emit(current_party)
	
func remove_hero_from_party(hero: Hero) -> void:
	if hero not in current_party:
		return

	current_party.erase(hero)
	current_party_reorganised.emit(current_party)

func is_hero_on_mission(hero: Hero) -> bool:
	for quest in process_quests:
		if hero in quest.assigned_party:
			return true
	return false

func start_current_quest() -> void:
	var quest := current_quest
	if quest == null or quest not in accepted_quests or quest.status != Quest.ACCEPTED:
		return
	if current_party.is_empty():
		return

	quest.assigned_party = current_party.duplicate()
	quest.remaining_days = maxi(1, quest.completion_time)
	quest.status = Quest.IN_PROGRESS
	process_quests.append(quest)
	current_party.clear()
	for hero in quest.assigned_party:
		HeroManager.make_hero_available(hero, false)

	quest.progress_changed.emit()
	current_party_reorganised.emit(current_party)
	on_quest_started.emit(quest)

func advance_missions() -> void:
	for quest: Quest in process_quests.duplicate():
		quest.remaining_days -= 1
		if quest.remaining_days == 0:
			quest.result = QuestResolver.calculate_result(quest, quest.assigned_party)
			quest.status = Quest.COMPLETED
			process_quests.erase(quest)
			completed_quests.append(quest)
			for hero in quest.assigned_party:
				HeroManager.make_hero_available(hero, true)
			on_quest_finished.emit(quest)
		quest.progress_changed.emit()

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
