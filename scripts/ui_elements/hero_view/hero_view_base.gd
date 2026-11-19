class_name HeroView extends Control

var hero : Hero

var name_label: RichTextLabel

var hp_bar: TextureProgressBar
var atk_bar: TextureProgressBar
var luck_bar: TextureProgressBar

func fill(hero_data: Hero) -> void:
	
	hero = hero_data
	
	name_label.text = hero_data.name
	
	hp_bar.value = hero_data.hp_current
	atk_bar.value = hero_data.atk
	luck_bar.value = hero_data.luck
