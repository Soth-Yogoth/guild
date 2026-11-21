extends Node

func calculate_result(quest: Quest, party: Array[Hero]) -> void:
	
	pass
	
func calculate_success_chance(quest: Quest, party: Array[Hero]) -> int:
	
	if quest == null or party.size() == 0: 
		return 0
	
	var success_result_value := 0.0
	var fail_result_value := 0.0
	
	for result in quest.positive_scenario:
		success_result_value += result.calculate_chance(party)
		
	for result in quest.negative_scenario:
		fail_result_value += result.calculate_chance(party)
		
	var chance = 100 / (success_result_value + fail_result_value) * success_result_value
	
	if chance > 0: return chance
	else: return 0
