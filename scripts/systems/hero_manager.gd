extends Node

@onready var heroes_database := load("res://resources/hero_database.tres") as HeroDatabase
@onready var guild_heroes := heroes_database.heroes

func _ready() -> void:
	
	print("bottom panel is ready")
	
	for hero in guild_heroes:
		print(hero.name)
