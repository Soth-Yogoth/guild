class_name Hero

signal max_hp_value_changed(value: int)
signal current_hp_value_changed(value: int)
signal atk_value_changed(value: int)
signal luck_value_changed(value: int)

var id: String
var name: String = "nobody"

var hp_max: int 
var hp_current: int :
	set(value):
		hp_current = value
		current_hp_value_changed.emit(value)

var atk: int :
	set(value):
		atk = value
		atk_value_changed.emit(value)
		
var luck: int :
	set(value):
		luck = value
		luck_value_changed.emit(value)

func _init() -> void:
	
	hp_max = randi_range(6, 8)
	hp_current = hp_max
	atk = randi_range(1, 6)
	luck = randi_range(1, 6)
	
static func create_from_data(data: HeroData) -> Hero:
	
	var instance = Hero.new()
	
	instance.name = data.name
	instance.hp_max = data.hp_max
	instance.hp_current = instance.hp_max
	instance.atk = data.atk
	instance.luck = data.luck
	
	return instance
