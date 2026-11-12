class_name HeroPreview extends Control

@onready var name_label := %NameLabel

@onready var hp_bar := %HP_ProgressBar
@onready var atk_bar := %ATK_ProgressBar
@onready var luck_bar := %Luck_ProgressBar

func make_connection(hero_data: Hero) -> void:

	fill(hero_data)
	
	hero_data.current_hp_value_changed.connect(
		func (value: int) : hp_bar.value = value)
	hero_data.atk_value_changed.connect(
		func (value: int) : atk_bar.value = value)
	hero_data.luck_value_changed.connect(
		func (value: int) : luck_bar.value = value)
	
	
func fill(hero_data: Hero) -> void:
	
	name_label.text = hero_data.name
	
	hp_bar.value = hero_data.hp_current
	atk_bar.value = hero_data.atk
	luck_bar.value = hero_data.luck
