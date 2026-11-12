extends Control

@onready var container := %HeroViewContainer
const hero_preview_scene := preload("res://scenes/preview/hero_preview.tscn")

func _ready() -> void:
	
	clear_container()
	
	for hero in HeroManager.guild_heroes:
		
		add_hero_view(hero)
		
func add_hero_view(hero: Hero) -> void:
	
	var hero_view_instance := hero_preview_scene.instantiate() as HeroPreview
	container.add_child(hero_view_instance)
	hero_view_instance.make_connection(hero)
	
func clear_container() -> void:
	
	for hero_view in container.get_children():
		hero_view.queue_free()
