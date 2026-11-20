class_name QuestData extends Resource

@export var id: String
@export var title: String
@export_multiline var description: String
@export var deadline: int
@export var upfront: int
@export var reward: int

@export var recommended_party_size: Array[int] = [1, 2, 3, 4]
@export var requirement_skills: Array[SkillRequirement] = []
