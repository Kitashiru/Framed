extends Control

@onready var CorrectSabotageCount = $ConditionContainer/VBoxContainer/CorrectSabotageCount
@onready var CorrectSabotageScore = $ConditionContainer/VBoxContainer/CorrectSabotageScore
@onready var WrongSabotageCount = $ConditionContainer/VBoxContainer/WrongSabotageCount2
@onready var WrongSabotageScore = $ConditionContainer/VBoxContainer/WrongSabotageScore2
@onready var MissedSabotageCount = $ConditionContainer/VBoxContainer/MissedSabotageCount
@onready var MissedSabotageScore = $ConditionContainer/VBoxContainer/MissedSabotageScore

@onready var FinalScoreLabel = $FinalScoreLabel

var CorrectGuesses = 0
var IncorrectGuesses = 0
var Missed = 0

var finalscore : int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CorrectGuesses = GameData.CorrectGuesses
	IncorrectGuesses = GameData.IncorrectGuesses
	Missed = GameData.MissedSabotages
	
	CorrectSabotageCount.text = "Sabotages Corrected: " + str(CorrectGuesses)
	CorrectSabotageScore.text = "+ " + str(CorrectGuesses * 50)
	WrongSabotageCount.text = "Incorrect Sabotages: " + str(IncorrectGuesses)
	WrongSabotageScore.text = "- " + str(IncorrectGuesses * 50)
	MissedSabotageCount.text = "Missed Sabotages: " + str(Missed)
	MissedSabotageScore.text = "- " + str(Missed * 50)
	finalscore = ((CorrectGuesses * 50) - (IncorrectGuesses * 50) - (Missed * 50)) + 195
	FinalScoreLabel.text = str(finalscore)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_next_button_pressed() -> void:
	MainMusic.stop()
	if finalscore >= 500:
		get_tree().change_scene_to_file("res://Menus/GoodEnding/GoodEnding.tscn")
	else:
		get_tree().change_scene_to_file("res://Menus/BadEnding/BadEnding.tscn")
