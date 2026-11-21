class_name QuestHeroSlot extends Control

@onready var hero_preview := %HeroPreview as HeroPreview

var hero: Hero
var _read_only := false

func _can_drop_data(pos, data) -> bool:
	return not _read_only and data is HeroPreview and data.drag_enabled and data.hero != null \
		and data != hero_preview and not QuestManager.is_hero_on_mission(data.hero)

func _drop_data(pos, data) -> void:
	if not _can_drop_data(pos, data):
		return

	var dragged_preview := data as HeroPreview
	var source_slot := dragged_preview.get_parent() as QuestHeroSlot
	var previous_hero := hero
	_set_hero(dragged_preview.hero)

	if source_slot != null:
		source_slot._set_hero(previous_hero)
	else:
		_return_to_roster(previous_hero)
		QuestManager.add_hero_to_party(hero)

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
	QuestManager.remove_hero_from_party(returned_hero)

func return_hero_to_roster() -> void:
	if _read_only:
		return

	var previous_hero := hero
	_set_hero(null)
	_return_to_roster(previous_hero)

func show_assignment(assigned_hero: Hero, read_only: bool) -> void:
	_read_only = read_only
	hero_preview.drag_enabled = not read_only
	hero_preview.remove_button.visible = not read_only
	_set_hero(assigned_hero)

func _on_hero_preview_dragged(preview: HeroPreview) -> void:
	preview.hide()

func _on_hero_preview_drag_lose(preview: HeroPreview) -> void:
	preview.visible = hero != null
