class_name HeroView extends Control

var hero : Hero

@onready var name_label: RichTextLabel = %NameLabel
@onready var stats := %HeroStats

func fill(hero_data: Hero) -> void:
	
	hero = hero_data
	
	name_label.text = hero_data.name
	
	stats.fill(hero_data)
