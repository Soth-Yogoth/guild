extends Node

signal quest_selected(quest: Quest)
signal hero_selected(hero: Hero)

func FillData() -> void:
	pass

func SelectQuest(quest: Quest) -> void: 
	quest_selected.emit(quest)
