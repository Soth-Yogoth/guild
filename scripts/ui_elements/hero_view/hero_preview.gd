class_name HeroPreview extends HeroView

signal close_button_pressed
signal dragged(hero_preview : HeroPreview)
signal drag_lose(hero_preview : HeroPreview)

var preview_dragged_scene := preload("res://scenes/preview/hero_preview_dragged.tscn")

@onready var is_dragged := false
var _click_pending := false

func make_connection(hero_data: Hero) -> void:

	fill(hero_data)
	
	hero_data.current_hp_value_changed.connect(
		func (value: int) : stats.hp_bar.value = value)
	hero_data.atk_value_changed.connect(
		func (value: int) : stats.atk_bar.value = value)
	hero_data.intelligence_value_changed.connect(
		func (value: int) : stats.intelligence_bar.value = value)
	hero_data.luck_value_changed.connect(
		func (value: int) : stats.luck_bar.value = value)
		
func _on_close_button_pressed() -> void:
	_click_pending = false
	close_button_pressed.emit()

func _gui_input(event: InputEvent) -> void:
	if not (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT):
		return

	if event.pressed:
		_click_pending = event.double_click
		return

	var open_details: bool = _click_pending and not event.canceled and hero != null \
		and Rect2(Vector2.ZERO, size).has_point(event.position)
	_click_pending = false
	if open_details:
		accept_event()
		UiManager.hero_selected.emit(hero)
	
func _get_drag_data(pos) -> Variant:
	_click_pending = false
	var preview_dragged_instance := preview_dragged_scene.instantiate() as HeroPreviewDragged
	set_drag_preview(preview_dragged_instance)
	preview_dragged_instance.fill(hero)
	
	is_dragged = true
	dragged.emit(self)
	
	return self
	
func _notification(what: int) -> void:
	
	if what == NOTIFICATION_DRAG_END:
		if not is_drag_successful() && is_dragged:
			drag_lose.emit(self)
		
		is_dragged = false
		
func lock() -> void:
	
	modulate = Color.DIM_GRAY
	mouse_behavior_recursive = Control.MOUSE_BEHAVIOR_DISABLED
	
func unlock() -> void:
	
	modulate = Color.WHITE
	mouse_behavior_recursive = Control.MOUSE_BEHAVIOR_INHERITED
	
