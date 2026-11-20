extends Node


func calculate_result(quest: Quest, party: Array[Hero]) -> void:
	
	pass
	
func calculate_chance(quest: Quest, party: Array[Hero]) -> float:
	
	var chance: = 0
	
	for size in quest.recommended_party_size:
		
		var value = 99 - pow((size - party.size()), 2) * 10
		chance = value if value > chance else chance
		
	for requirement in quest.requirement_skills:
		
		var value = chance * 
		
	chance += quest.requirementHeroesMin
	
	return 0
