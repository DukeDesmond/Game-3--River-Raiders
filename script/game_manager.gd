extends Node

var score = 0
@onready var labelScore = $score
func add_score100(new_score = 100):
	score += new_score
	labelScore.text = str(score)


func add_score500(new_score = 500):
	score += new_score
	labelScore.text = str(score)
