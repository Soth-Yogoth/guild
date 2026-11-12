class_name Quest

var id: String
var title: String
var description: String
var deadline: int
var reward: int

func _init(data: QuestData) -> void:
	self.title = data.title
	self.description = data.description
	self.deadline = data.deadline
	self.reward = data.reward
