class_name QuestHeroSlot extends Control

signal hero_added(hero: Hero)
signal hero_removed(hero: Hero)

@onready var hero_preview := %HeroPreview as HeroPreview

var hero: Hero

func _can_drop_data(pos, data) -> bool:
	return data is HeroPreview and data.hero != null and data != hero_preview

func _drop_data(pos, data) -> void:
	
	var dragged_preview := data as HeroPreview
	var source_slot := dragged_preview.get_parent() as QuestHeroSlot
	var previous_hero := hero
	_set_hero(dragged_preview.hero)

	if source_slot != null:
		source_slot._set_hero(previous_hero)
	else:
		_return_to_roster(previous_hero)
		hero_added.emit(hero)

func _set_hero(new_hero: Hero) -> void:
	
	hero = new_hero
	hero_preview.visible = hero != null
	if hero == null:
		hero_preview.hero = null
		return

	hero_preview.fill(hero)
	hero_preview.mouse_filter = MOUSE_FILTER_PASS

func _return_to_roster(returned_hero: Hero) -> void:
	
	if returned_hero == null:
		return

	HeroManager.return_hero_into_stuck(returned_hero)
	hero_removed.emit(returned_hero)

func return_hero_to_roster() -> void:
	
	var previous_hero := hero
	_set_hero(null)
	_return_to_roster(previous_hero)

func _on_hero_preview_dragged(preview: HeroPreview) -> void:
	preview.hide()

func _on_hero_preview_drag_lose(preview: HeroPreview) -> void:
	preview.visible = hero != null
