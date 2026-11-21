extends QuestView

signal on_close_button_pressed

@onready var hero_slots := %HeroSlots as HBoxContainer
@onready var party_section := hero_slots.get_parent() as HBoxContainer
@onready var result_description: RichTextLabel = %QuestResultDescription

var start_quest_button: BaseButton
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
	start_quest_button.pressed.connect(QuestManager.start_current_quest)
	
func _on_close_button_pressed() -> void:
	
	on_close_button_pressed.emit()

func _on_current_quest_changed(_quest: Quest) -> void:
	for slot in hero_slots.get_children():
		if slot is QuestHeroSlot:
			slot.return_hero_to_roster()
			slot.show_assignment(null, false)

func _refresh_quest_state() -> void:
	super._refresh_quest_state()
	if quest != QuestManager.current_quest:
		return

	var is_completed := quest.status == Quest.COMPLETED
	party_section.visible = not is_completed
	result_description.visible = is_completed
	result_description.text = _get_result_description() if is_completed else ""

	if quest.status == Quest.IN_PROGRESS:
		var index := 0
		for slot in hero_slots.get_children():
			if slot is QuestHeroSlot:
				var assigned_hero: Hero = quest.assigned_party[index] if index < quest.assigned_party.size() else null
				slot.show_assignment(assigned_hero, true)
				index += 1
	_on_party_reorganised(QuestManager.current_party)

func _get_result_description() -> String:
	if quest.result == null:
		return "Результат не определён."

	var description := quest.result.description
	if not description.contains("{hero_name}") or quest.assigned_party.is_empty():
		return description

	var smartest_hero := quest.assigned_party[0]
	for hero in quest.assigned_party:
		if hero.intelligence > smartest_hero.intelligence:
			smartest_hero = hero

	return description.replace("{hero_name}", smartest_hero.name)

func _on_party_reorganised(party: Array[Hero]) -> void:
	if quest == null or quest != QuestManager.current_quest:
		return

	var is_accepted := quest.status == Quest.ACCEPTED
	start_quest_button.visible = is_accepted and not party.is_empty()
	chance_preview.visible = is_accepted
	completion_time_preview.visible = quest.status != Quest.COMPLETED
	if not is_accepted:
		completion_time_preview.text = "До завершения: %d дн." % quest.remaining_days
		return

	var chance = QuestResolver.calculate_success_chance(quest, party)
	chance_preview.text = "Шанс успеха: " + str(chance) + "%"
	
	completion_time_preview.text = "Время выполнения: %d дн." % maxi(1, quest.completion_time)
	
