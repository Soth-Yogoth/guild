class_name HeroPanel extends Control

@onready var hero_dictionary : Dictionary[Hero, HeroPreview] = {}
@onready var container := %HeroViewContainer
const hero_preview_scene := preload("res://scenes/preview/hero_preview.tscn")

func _ready() -> void:
	
	clear_container()
	
	HeroManager.set_hero_panel(self)
	for hero in HeroManager.guild_heroes:
		
		add_hero_view(hero)
		
func add_hero_view(hero: Hero) -> void:
	
	var hero_view_instance := hero_preview_scene.instantiate() as HeroPreview
	container.add_child(hero_view_instance)
	hero_view_instance.make_connection(hero)
	
	hero_dictionary[hero] = hero_view_instance
	if QuestManager.is_hero_on_mission(hero):
		hero_view_instance.lock()
	
	hero_view_instance.dragged.connect(on_hero_preview_drag)
	hero_view_instance.drag_lose.connect(on_hero_preview_lose_drag)
	
func clear_container() -> void:
	
	for hero_view in container.get_children():
		hero_view.queue_free()
		
func on_hero_preview_drag(hero_preview : HeroPreview) -> void:
	
	hero_preview.lock()
	
func on_hero_preview_lose_drag(hero_preview : HeroPreview) -> void:
	
	hero_preview.unlock()
 
func set_hero_available(hero: Hero, available: bool) -> void:
	var preview: HeroPreview = hero_dictionary.get(hero)
	if preview == null:
		return
	if available:
		preview.unlock()
	else:
		preview.lock()
