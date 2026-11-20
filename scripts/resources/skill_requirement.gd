class_name SkillRequirement extends Resource

enum Skill
{
	MIGHT,
	INTELLIGENCE,
	LUCK
}

enum Method
{
	SUM,
	MIN,
	EXIST,
	AVERAGE
}

@export var skill := Skill.MIGHT
@export var method := Method.MIN
@export var requirement_value := 0

func calculate(skill_values: Array[int]) -> float:
	
	var result := 0.0
	var action : Callable = Sum
	
	match method:
		Method.SUM: action = Sum
		Method.MIN: action = Min
		Method.EXIST: action = Exist
		Method.AVERAGE: action = Average
	
	return action.call(skill_values)
		 

func Sum(values:  Array[int]) -> float:
	
	var result := 0.0 - requirement_value
	
	for value in values:
		result += value
		
	return result

func Min(values:  Array[int]) -> float:
	
	var min = values[0]
	
	for value in values:
		min = value if value < min else min
	
	var result = min - requirement_value
	
	return float(result)

func Exist(values:  Array[int]) -> float:
	
	for value in values:
		if value > 0: return 50
		
	return -50

func Average(values:  Array[int]) -> float:
	
	var sum := 0.0
	
	for value in values:
		sum += value
		
	var result := (sum / values.size() - requirement_value) * 10
	
	return result
