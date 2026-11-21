extends QuestView

signal on_close_button_pressed

@onready var hero_slots := %HeroSlots as HBoxContainer

var start_quest_button: Control
var chance_preview: RichTextLabel
var completion_time_preview: RichTextLabel

func _ready() -> void:
	
	title_label = %QuestTitle
	description_label = %QuestDescription
	deadline_label = %DeadlineLabel
	
	start_quest_button = %StartQuestButton
	QuestManager.current_party_reorganised.connect(_on_party_reorganised)
	QuestManager.current_quest_changed.connect(_on_current_quest_changed)
	
	chance_preview = %ChancePreviewLabel
	completion_time_preview = %CompletionTimeLabel
	
func _on_close_button_pressed() -> void:
	
	on_close_button_pressed.emit()

func _on_current_quest_changed(_quest: Quest) -> void:
	for slot in hero_slots.get_children():
		if slot is QuestHeroSlot:
			slot.return_hero_to_roster()
	
func _on_party_reorganised(party: Array[Hero]) -> void:
	
	start_quest_button.visible = party.size() > 0
	
	var chance = QuestResolver.calculate_success_chance(quest, party)
	chance_preview.text = "Шанс успеха: " + str(chance) + "%"
	
	completion_time_preview.text = "Время выполнения: " + \
		str(quest.completion_time) if chance > 0 else "0" + " дней."
	
