extends Control

@onready var CorrectSabotageCount = $ConditionContainer/VBoxContainer/CorrectSabotageCount
@onready var CorrectSabotageScore = $ConditionContainer/VBoxContainer/CorrectSabotageScore
@onready var WrongSabotageCount = $ConditionContainer/VBoxContainer/WrongSabotageCount2
@onready var WrongSabotageScore = $ConditionContainer/VBoxContainer/WrongSabotageScore2
@onready var FinalScoreLabel = $FinalScoreLabel

var CorrectGuesses = 0
var IncorrectGuesses = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CorrectGuesses = GameData.CorrectGuesses
	IncorrectGuesses = GameData.IncorrectGuesses
	
	CorrectSabotageCount.text = "Sabotages Corrected: " + str(CorrectGuesses)
	CorrectSabotageScore.text = "+ " + str(CorrectGuesses * 50)
	WrongSabotageCount.text = "Incorrect Sabotages: " + str(IncorrectGuesses)
	WrongSabotageScore.text = "- " + str(IncorrectGuesses * 50)
	FinalScoreLabel.text = str( ((CorrectGuesses * 50) - (IncorrectGuesses * 50)) + 195 )

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_next_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/MainMenu/MainMenu.tscn")
