extends Node

var _rng := RandomNumberGenerator.new()

func calculate_result(quest: Quest, party: Array[Hero]) -> QuestResult:
	if quest == null or party.is_empty():
		return null

	var outcomes: Array[QuestResult] = quest.positive_scenario + quest.negative_scenario
	var weights := _calculate_outcome_weights(outcomes, party)
	if weights.count(0.0) == weights.size():
		return null

	return outcomes[_rng.rand_weighted(weights)]

func calculate_success_chance(quest: Quest, party: Array[Hero]) -> int:
	if quest == null or party.is_empty():
		return 0

	var outcomes: Array[QuestResult] = quest.positive_scenario + quest.negative_scenario
	var weights := _calculate_outcome_weights(outcomes, party)
	var positive_count := quest.positive_scenario.size()
	var success_weight := 0.0
	var total_weight := 0.0
	for index in range(weights.size()):
		var weight := weights[index]
		total_weight += weight
		if index < positive_count:
			success_weight += weight

	if total_weight == 0.0:
		return 0
	return int(100.0 * (success_weight / total_weight))

func _calculate_outcome_weights(outcomes: Array[QuestResult], party: Array[Hero]) -> PackedFloat32Array:
	var weights := PackedFloat32Array()
	weights.resize(outcomes.size())

	for index in range(outcomes.size()):
		var outcome := outcomes[index]
		if outcome == null:
			continue

		var weight := outcome.calculate_chance(party)
		if is_finite(weight) and weight > 0.0:
			weights[index] = weight

	return weights
