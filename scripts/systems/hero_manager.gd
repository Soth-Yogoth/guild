extends Node

@onready var heroes_database := load("res://resources/hero_database.tres") as HeroDatabase
@onready var guild_heroes : Array[Hero]

func _ready() -> void:
	
	for hero_data in heroes_database.heroes:
		guild_heroes.append(Hero.create_from_data(hero_data))
