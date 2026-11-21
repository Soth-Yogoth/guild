class_name Quest

signal progress_changed

const ACCEPTED := &"accepted"
const IN_PROGRESS := &"in_progress"
const COMPLETED := &"completed"

var id: String
var title: String
var description: String
var deadline: int
var completion_time: int
var reward: int
var status := ACCEPTED
var assigned_party: Array[Hero]
var remaining_days: int

var positive_scenario: Array[QuestResult]
var negative_scenario: Array[QuestResult]

var result: QuestResult

func _init(data: QuestData) -> void:

	self.title = data.title
	self.description = data.description
	self.deadline = data.deadline
	self.completion_time = data.completion_time
	self.reward = data.reward
	
	self.positive_scenario = data.positive_scenario
	self.negative_scenario = data.negative_scenario
