extends VBoxContainer

@onready var hp_bar: TextureProgressBar = %HealthBar
@onready var atk_bar: TextureProgressBar = %MightBar
@onready var intelligence_bar: TextureProgressBar = %IntelligenceBar
@onready var luck_bar: TextureProgressBar = %LuckBar

func fill(hero: Hero) -> void:
	hp_bar.max_value = maxi(1, hero.hp_max)
	hp_bar.value = hero.hp_current
	atk_bar.value = hero.atk
	intelligence_bar.value = hero.intelligence
	luck_bar.value = hero.luck
