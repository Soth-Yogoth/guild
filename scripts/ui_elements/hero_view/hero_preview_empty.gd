extends Control

signal hero_added(hero: Hero)
signal hero_removed(hero: Hero)

@onready var hero_preview := %HeroPreview
var hero_preview_buffer : HeroPreview

var hero : Hero

func _can_drop_data(pos, data) -> bool:

	return data is Hero
	
func _drop_data(pos, data) -> void:
	
	if (not hero == null):
		HeroManager.return_hero_into_stuck(hero)
	
	hero = data
	hero_added.emit(hero)
	
	hero_preview.show()
	hero_preview.fill(data)
	hero_preview.mouse_filter = MOUSE_FILTER_PASS

func _on_hero_preview_close_button_pressed() -> void:
	
	HeroManager.return_hero_into_stuck(hero)
	hero_preview.hide()

func _on_hero_preview_dragged(hero_preview: HeroPreview) -> void:
	
	hero = null
	
	hero_preview.hide()
	hero_preview.mouse_filter = MOUSE_FILTER_IGNORE

func _on_hero_preview_drag_lose(hero_preview: HeroPreview) -> void:
	
	hero_preview.show()
	hero_preview.mouse_filter = MOUSE_FILTER_STOP
