class_name Quest

var id: String
var title: String
var description: String
var deadline: int
var reward: int

var recommended_party_size: Array[int] = [1, 2, 3, 4]
var requirement_skills: Array[SkillRequirement] = []

func _init(data: QuestData) -> void:

	self.title = data.title
	self.description = data.description
	self.deadline = data.deadline
	self.reward = data.reward
	
	self.recommended_party_size = data.recommended_party_size
	self.requirement_skills = data.requirement_skills
