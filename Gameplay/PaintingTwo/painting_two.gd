extends Node2D

#face Checkboxes
@onready var EyesCheckBox = $SabotageMenu/FaceContainer/EyesCheckBox
@onready var EyebrowsCheckBox = $SabotageMenu/FaceContainer/EyebrowsCheckBox
@onready var MouthCheckBox = $SabotageMenu/FaceContainer/MouthCheckBox
@onready var MakeupCheckBox = $SabotageMenu/FaceContainer/MakeupCheckBox
@onready var HairCheckBox = $SabotageMenu/FaceContainer/HairCheckBox

#Outfit Checkboxes
@onready var HatCheckBox = $SabotageMenu/OutfitContainer/HatCheckBox
@onready var EarringCheckBox = $SabotageMenu/OutfitContainer/EarringCheckBox
@onready var TopCheckBox = $SabotageMenu/OutfitContainer/TopCheckBox
@onready var OuterWearCheckBox = $SabotageMenu/OutfitContainer/OuterWearCheckBox
@onready var NeckWearCheckBox = $SabotageMenu/OutfitContainer/NeckwearCheckBox

#Backround Checkboxes
@onready var SkyCheckBox = $SabotageMenu/BackroundContainer/SkyCheckBox
@onready var SeaCheckBox = $SabotageMenu/BackroundContainer/SeaCheckBox
@onready var HouseCheckBox = $SabotageMenu/BackroundContainer/HouseCheckBox
@onready var DecorationsCheckBox = $SabotageMenu/BackroundContainer/DecorationsCheckBox

#Color Checkboxes
@onready var TopColorCheckBox = $SabotageMenu/ColorContainer/TopColorCheckBox
@onready var HairColorCheckBox = $SabotageMenu/ColorContainer/HairColorCheckBox
@onready var HatColorCheckBox = $SabotageMenu/ColorContainer/HatColorCheckBox

@onready var SabatogeTimer = $SabatogeTimer
@onready var ResetTimer = $ResetTimer
@onready var PaintingSprite = $Painting
@onready var animationplayer = $AnimationPlayer

var CorrectGuesses = 0
var IncorrectGuesses = 0

var baseImgPath = "res://Assets/PaintingTwo/base_scream_painting.png"
var ImgFolderPath = "res://Assets/PaintingTwo/"

var rng = RandomNumberGenerator.new()

enum PaintingState{
	Rest,
	Mischievous,
	Sabotage1,
	Sabotage2,
	Sabotage3,
	Sabotage4
}

var CurrentState = PaintingState.Rest


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func ChangeToMischievous() -> void:
	CurrentState = PaintingState.Mischievous
	
#func ChangeToSabatoge() -> void:
#	CurrentState = PaintingState.Sabatoge

func StartSabatogeTimer(Running: bool) -> void:
	if SabatogeTimer.is_stopped():
		SabatogeTimer.start()
		ResetTimer.stop()

func StartResetTimer(Running: bool) -> void:
	if ResetTimer.is_stopped():
		ResetTimer.start()
		SabatogeTimer.stop()

func _on_reset_timer_timeout() -> void:
	print("rest timer started")
	CurrentState = PaintingState.Rest


func _on_sabatoge_timer_timeout() -> void:
	setSabotage()
	ResetTimer.stop()
	SabatogeTimer.stop()

func setSabotage():
	var SabotageNumber = rng.randi_range(1, 4)
	if SabotageNumber == 1:
		PaintingSprite.texture = load(ImgFolderPath + "sab" + str(SabotageNumber) + "_scream_painting.png")
		CurrentState = PaintingState.Sabotage1
	elif SabotageNumber == 2:
		PaintingSprite.texture = load(ImgFolderPath + "sab" + str(SabotageNumber) + "_scream_painting.png")
		CurrentState = PaintingState.Sabotage2
	elif SabotageNumber == 3:
		PaintingSprite.texture = load(ImgFolderPath + "sab" + str(SabotageNumber) + "_scream_painting.png")
		CurrentState = PaintingState.Sabotage3
	elif SabotageNumber == 4:
		PaintingSprite.texture = load(ImgFolderPath + "sab" + str(SabotageNumber) + "_scream_painting.png")
		CurrentState = PaintingState.Sabotage4

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_click"): # 'left_click' should be set up in Project Settings
		#print("2D object clicked!")
		$SabotageMenu.visible = true

func _on_check_button_pressed() -> void:
	match CurrentState:
		PaintingState.Sabotage1:
			handle_sabotage1()
		PaintingState.Sabotage2:
			handle_sabotage2()
		PaintingState.Sabotage3:
			handle_sabotage3()
		PaintingState.Sabotage4:
			handle_sabotage4()
		_: 
			IncorrectGuesses += 1
	$SabotageMenu.visible = false
	ClearCheckBoxes()

func handle_sabotage1():
	var other_boxes := [
		EyesCheckBox,
		EyebrowsCheckBox,
		MouthCheckBox,
		MakeupCheckBox,
		HairCheckBox,
		HatCheckBox,
		EarringCheckBox,
		TopCheckBox,
		OuterWearCheckBox,
		NeckWearCheckBox,
		SkyCheckBox,
		SeaCheckBox,
		HouseCheckBox,
		TopColorCheckBox,
		HairColorCheckBox,
		HatColorCheckBox
	]

	var any_other_pressed := false
	for box in other_boxes:
		if box.button_pressed:
			any_other_pressed = true
			break

	var is_correct: bool = DecorationsCheckBox.button_pressed and not any_other_pressed

	if is_correct:
		CorrectGuesses += 1
	else:
		IncorrectGuesses += 1

	CurrentState = PaintingState.Rest
	PaintingSprite.texture = load(baseImgPath)
	SabatogeTimer.stop()

func handle_sabotage2():
	var other_boxes := [
		EyesCheckBox,
		EyebrowsCheckBox,
		MouthCheckBox,
		MakeupCheckBox,
		HairCheckBox,
		HatCheckBox,
		EarringCheckBox,
		TopCheckBox,
		OuterWearCheckBox,
		NeckWearCheckBox,
		SkyCheckBox,
		HouseCheckBox,
		DecorationsCheckBox,
		TopColorCheckBox,
		HairColorCheckBox,
		HatColorCheckBox
	]

	var any_other_pressed := false
	for box in other_boxes:
		if box.button_pressed:
			any_other_pressed = true
			break

	var is_correct: bool = SeaCheckBox.button_pressed and not any_other_pressed

	if is_correct:
		CorrectGuesses += 1
	else:
		IncorrectGuesses += 1

	CurrentState = PaintingState.Rest
	PaintingSprite.texture = load(baseImgPath)
	SabatogeTimer.stop()

func handle_sabotage3():
	var other_boxes := [
		EyesCheckBox,
		EyebrowsCheckBox,
		MouthCheckBox,
		MakeupCheckBox,
		HairCheckBox,
		HatCheckBox,
		EarringCheckBox,
		TopCheckBox,
		OuterWearCheckBox,
		NeckWearCheckBox,
		SeaCheckBox,
		HouseCheckBox,
		DecorationsCheckBox,
		TopColorCheckBox,
		HairColorCheckBox,
		HatColorCheckBox
	]

	var any_other_pressed := false
	for box in other_boxes:
		if box.button_pressed:
			any_other_pressed = true
			break

	var is_correct: bool = SkyCheckBox.button_pressed and not any_other_pressed

	if is_correct:
		CorrectGuesses += 1
	else:
		IncorrectGuesses += 1

	CurrentState = PaintingState.Rest
	PaintingSprite.texture = load(baseImgPath)
	SabatogeTimer.stop()

func handle_sabotage4():
	var other_boxes := [
		EyebrowsCheckBox,
		MakeupCheckBox,
		HairCheckBox,
		HatCheckBox,
		EarringCheckBox,
		OuterWearCheckBox,
		NeckWearCheckBox,
		SkyCheckBox,
		SeaCheckBox,
		HouseCheckBox,
		DecorationsCheckBox,
		TopColorCheckBox,
		HairColorCheckBox,
		HatColorCheckBox
	]

	var any_other_pressed := false
	for box in other_boxes:
		if box.button_pressed:
			any_other_pressed = true
			break

	var is_correct: bool = EyesCheckBox.button_pressed and TopCheckBox.button_pressed and MouthCheckBox.button_pressed and not any_other_pressed

	if is_correct:
		CorrectGuesses += 1
	else:
		IncorrectGuesses += 1

	CurrentState = PaintingState.Rest
	PaintingSprite.texture = load(baseImgPath)
	SabatogeTimer.stop()

func _on_close_button_pressed() -> void:
	$SabotageMenu.visible = false
	ClearCheckBoxes()


func _on_face_button_pressed() -> void:
	animationplayer.play("RESET")
	await animationplayer.animation_finished
	animationplayer.play("ShowFaceContainer")


func _on_outfit_button_pressed() -> void:
	animationplayer.play("RESET")
	await animationplayer.animation_finished
	animationplayer.play("ShowOutfitContainer")


func _on_backround_button_pressed() -> void:
	animationplayer.play("RESET")
	await animationplayer.animation_finished
	animationplayer.play("ShowBackroundContainer")

func _on_color_button_pressed() -> void:
	animationplayer.play("RESET")
	await animationplayer.animation_finished
	animationplayer.play("ShowColorContainer")

func ClearCheckBoxes():
	var check_boxes := [
		EyesCheckBox,
		EyebrowsCheckBox,
		MouthCheckBox,
		MakeupCheckBox,
		HairCheckBox,
		HatCheckBox,
		EarringCheckBox,
		TopCheckBox,
		OuterWearCheckBox,
		NeckWearCheckBox,
		SkyCheckBox,
		SeaCheckBox,
		HouseCheckBox,
		DecorationsCheckBox,
		TopColorCheckBox,
		HairColorCheckBox,
		HatColorCheckBox
	]
	for box in check_boxes:
		box.button_pressed = false
