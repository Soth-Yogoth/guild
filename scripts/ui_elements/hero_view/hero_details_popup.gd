extends PopupPanel

@onready var hero_name: RichTextLabel = %HeroName
@onready var stats := %HeroStats
@onready var close_button: Button = %CloseButton

func _ready() -> void:
	UiManager.hero_selected.connect(show_hero)
	close_requested.connect(hide)
	close_button.pressed.connect(hide)

func show_hero(hero: Hero) -> void:
	hero_name.text = hero.name
	stats.fill(hero)
	popup_centered()
