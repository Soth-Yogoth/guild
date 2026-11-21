class_name QuestResult extends Resource

@export var id: String
@export var title: String
@export_multiline var description: String

@export var reward_modifier: float

@export var base_chance: float = 1

@export var recommended_party_size: Array[int] = [1, 2, 3, 4]
@export var requirement_skills: Array[SkillRequirement] = []

func calculate_chance(party: Array[Hero]) -> float:
	
	var chance: = base_chance
	var party_size_modifier := 1.0 if recommended_party_size.is_empty() else 0.0
	
	for size in recommended_party_size:
		
		var value := 1.0 - pow(size - party.size(), 2) * 0.1
		party_size_modifier = maxf(party_size_modifier, value)

	chance = chance * party_size_modifier
		
	for requirement in requirement_skills:
		
		var heroes_skills : Array[int] = []
		
		for hero in party:
			
			heroes_skills.append(hero.get_skill_value(requirement.skill))
			
		chance += requirement.calculate(heroes_skills)
	
	return chance
