extends Node

@onready var heroes_database := load("res://resources/hero_database.tres") as HeroDatabase
@onready var guild_heroes : Array[Hero]

var hero_panel : HeroPanel

func _ready() -> void:
	
	for hero_data in heroes_database.heroes:
		guild_heroes.append(Hero.create_from_data(hero_data))

func set_hero_panel(panel : HeroPanel) -> void:
	hero_panel = panel

func return_hero_into_stuck(hero : Hero) -> void:
	hero_panel.return_hero(hero)
	
func make_hero_available(hero_id : int, status : bool) -> void:
	pass
