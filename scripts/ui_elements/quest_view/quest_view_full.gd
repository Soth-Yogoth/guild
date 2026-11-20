extends QuestView

signal on_close_button_pressed

var start_quest_button: Control
var chance_preview: RichTextLabel

func _ready() -> void:
	
	title_label = %QuestTitle
	description_label = %QuestDescription
	deadline_label = %DeadlineLabel
	
	start_quest_button = %StartQuestButton
	QuestManager.current_party_reorganised.connect(_on_party_reorganised)

func _on_close_button_pressed() -> void:
	
	on_close_button_pressed.emit()
	
func _on_party_reorganised(party: Array[Hero]) -> void:
	
	start_quest_button.visible = party.size() > 0
	
