class_name QuestPreview extends QuestView

var preview_dragable_scene = preload("res://scenes/preview/quest_preview_dragged.tscn")

func _ready() -> void:
	title_label = %TitleLabel
	description_label = %ContentLabel
	deadline_label = %DeadlineLabel
		
func _get_drag_data(pos) -> Variant:
	
	var preview_dragable_instance := preview_dragable_scene.instantiate() as QuestPreviewDragged
	set_drag_preview(preview_dragable_instance)
	preview_dragable_instance.fill(quest)
	
	return quest
