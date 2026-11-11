class_name HeroData extends Resource

const max_value = 8

@export var id: String
@export var name: String

@export var hp_max: int = 8:
	set(value):
		hp_max = clampf(value, 0.0, max_value)
		
@export var atk: int = 1:
	set(value):
		atk = clampf(value, 0.0, max_value)
		
@export var luck: int = 1:
	set(value):
		luck = clampf(value, 0.0, max_value)
