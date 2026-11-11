extends Control

@onready var container := %HeroViewContainer
const hero_view_scene := preload("res://scenes/hero_view_short.tscn")

func _ready() -> void:
	
	clear_container()
	
	for hero_data in HeroManager.guild_heroes:
		
		var hero := Hero.create_from_data(	hero_data)
		add_hero_view(hero)
		
func add_hero_view(hero: Hero) -> void:
	
	var hero_view_instance := hero_view_scene.instantiate() as HeroView
	container.add_child(hero_view_instance)
	hero_view_instance.make_connection(hero)
	
func clear_container() -> void:
	
	for hero_view in container.get_children():
		hero_view.queue_free()
