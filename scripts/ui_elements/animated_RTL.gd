extends RichTextLabel

var tween : Tween

func _ready() -> void:
	gui_input.connect(_on_gui_input)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		finish_animation()

func start_animation() -> void:
	
	hide_text()
	
	tween = create_tween()
	tween.tween_property(self, "visible_ratio", 1.0, 5)
	
func finish_animation() -> void:
	
	tween.kill()
	visible_ratio = 1.0
	
func hide_text() -> void:
	visible_ratio = 0.0
