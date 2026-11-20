class_name HeroPreview extends HeroView

signal close_button_pressed
signal dragged(hero_preview : HeroPreview)
signal drag_lose(hero_preview : HeroPreview)

var preview_dragged_scene := preload("res://scenes/preview/hero_preview_dragged.tscn")

@onready var is_dragged := false

func _ready() -> void:
	
	name_label = %NameLabel
	
	hp_bar = %HP_ProgressBar
	atk_bar = %ATK_ProgressBar
	luck_bar = %Luck_ProgressBar
	
func make_connection(hero_data: Hero) -> void:

	fill(hero_data)
	
	hero_data.current_hp_value_changed.connect(
		func (value: int) : hp_bar.value = value)
	hero_data.atk_value_changed.connect(
		func (value: int) : atk_bar.value = value)
	hero_data.luck_value_changed.connect(
		func (value: int) : luck_bar.value = value)
		
func _on_close_button_pressed() -> void:
	close_button_pressed.emit()
	
func _get_drag_data(pos) -> Variant:
	
	var preview_dragged_instance := preview_dragged_scene.instantiate() as HeroPreviewDragged
	set_drag_preview(preview_dragged_instance)
	preview_dragged_instance.fill(hero)
	
	is_dragged = true
	dragged.emit(self)
	
	return hero
	
func _notification(what: int) -> void:
	
	if what == NOTIFICATION_DRAG_END:
		if not is_drag_successful() && is_dragged:
			drag_lose.emit(self)
			
		is_dragged = false
		
func lock() -> void:
	
	modulate = Color.DIM_GRAY
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func unlock() -> void:
	
	modulate = Color.WHITE
	mouse_filter = Control.MOUSE_FILTER_STOP
	
