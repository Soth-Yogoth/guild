class_name QuestPreview extends QuestView

var preview_dragable_scene = preload("res://scenes/preview/quest_preview_dragged.tscn")
var _click_pending := false

func _ready() -> void:
	title_label = %TitleLabel
	description_label = %ContentLabel
	deadline_label = %DeadlineLabel
		
func _get_drag_data(pos) -> Variant:
	_click_pending = false
	var preview_dragable_instance := preview_dragable_scene.instantiate() as QuestPreviewDragged
	set_drag_preview(preview_dragable_instance)
	preview_dragable_instance.fill(quest)
	
	return quest
	
func _gui_input(event: InputEvent) -> void:
	if not (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT):
		return

	if event.pressed:
		_click_pending = event.double_click
		return

	var open_details: bool = _click_pending and not event.canceled and quest != null \
		and Rect2(Vector2.ZERO, size).has_point(event.position)
	_click_pending = false
	if open_details:
		accept_event()
		UiManager.SelectQuest(quest)
