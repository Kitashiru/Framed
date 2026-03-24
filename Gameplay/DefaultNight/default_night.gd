extends Node2D

@onready var Self = $"."
@onready var CameraSystem = $CameraSystem
@onready var LeftNotice = $CanvasLayer/Left
@onready var RightNotice = $CanvasLayer/Right

@onready var LeftPainting = $PaintingTwo
@onready var MiddlePainting = $PaintingOne
@onready var RightPainting = $PaintingThree

@onready var PauseScreen = $PauseScreen

@onready var SFXPlayer = $CanvasLayer/SfxPlayer

var PaintingList = []

var rng = RandomNumberGenerator.new()

var CurrentTime = 12
var LastUpdatedTime

var HintsLeft = 3
@onready var HintLabel = $CanvasLayer/HintIndicator/Label

var score = 0
var LastUpdatedScore
@onready var ScoreLabel = $CanvasLayer/ScoreLabel

@onready var TimeLabel = $CanvasLayer/Label
@onready var AM_PM_Label = $CanvasLayer/Label2
@onready var EventTimer = $EventTimer
@export var MinimumEventTime:int
@export var MaximumEventTime:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
	PlayIntro()
	var random_time = rng.randi_range(MinimumEventTime, MaximumEventTime)
	EventTimer.wait_time = random_time
	EventTimer.start()
	PaintingList = [MiddlePainting, LeftPainting, RightPainting]

func PlayIntro() -> void:
	Dialogic.timeline_ended.connect(IntroEnded)
	Dialogic.timeline_started.connect(IntroStarted)
	Dialogic.start("Intro")

func IntroStarted():
	Self.process_mode = ProcessMode.PROCESS_MODE_DISABLED
	
func IntroEnded():
	Self.process_mode = ProcessMode.PROCESS_MODE_INHERIT

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if LastUpdatedTime != CurrentTime:
		TimeLabel.text = ChangeTimeToString(CurrentTime)
		LastUpdatedTime = CurrentTime
	
	if score != MiddlePainting.points + LeftPainting.points + RightPainting.points:
		score = MiddlePainting.points + LeftPainting.points + RightPainting.points
	
	if score != LastUpdatedScore:
		ScoreLabel.text = str(score)
		LastUpdatedScore = score

	for i in range(PaintingList.size()):
		var painting = PaintingList[i]

		if i == CameraSystem.CurrentPosition: #looking at painting
			#print("Player is looking at", painting.name)
			if painting.CurrentState == 1: #Checking if painting is Mischievous
				painting.StartResetTimer(true)
		else: #not looking at painting
			if painting.CurrentState == 1:#Checking if painting is Mischievous
				painting.StartSabatogeTimer(true)
				


func ChangeTimeToString(time: float) -> String:
	if not ".5" in str(time):
		return str(int(time)) + ":00"
	else:
		return str(int(time - .5)) + ":30"

func _on_event_timer_timeout() -> void:
	#get what painting you are currently looking at
	var CurrentCamPos = CameraSystem.CurrentPosition
	if CurrentCamPos == 0: #Middle
		var random = rng.randi_range(1, 2)
		if random == 1:
			if LeftPainting.CurrentState == 0:
				LeftPainting.ChangeToMischievous()
				LeftNotice.visible = true
				await get_tree().create_timer(2).timeout
				LeftNotice.visible = false
		if random == 2:
			if RightPainting.CurrentState == 0:
				RightPainting.ChangeToMischievous()
				RightNotice.visible = true
				await get_tree().create_timer(2).timeout
				RightNotice.visible = false

	elif CurrentCamPos == 1: #Left
		var random = rng.randi_range(1, 2) # 1=Middle 2=Right
		if random == 1:
			if MiddlePainting.CurrentState == 0:
				MiddlePainting.ChangeToMischievous()
		else:
			if RightPainting.CurrentState == 0:
				RightPainting.ChangeToMischievous()
		RightNotice.visible = true
		await get_tree().create_timer(2).timeout
		RightNotice.visible = false

	elif CurrentCamPos == 2: #Right
		var random = rng.randi_range(1, 2) # 1=Middle 2=Left
		if random == 1:
			if MiddlePainting.CurrentState == 0:
				MiddlePainting.ChangeToMischievous()
		else:
			if LeftPainting.CurrentState == 0:
				LeftPainting.ChangeToMischievous()
		LeftNotice.visible = true
		await get_tree().create_timer(2).timeout
		LeftNotice.visible = false


func _on_timer_timeout() -> void:
	if CurrentTime == 12:
		AM_PM_Label.text = "AM"
	if CurrentTime == 12.5:
		CurrentTime = 1
	else:
		CurrentTime += 0.5
		if CurrentTime == 6:
			get_tree().change_scene_to_file("res://Menus/ResultsScreen/ResultsScreen.tscn")


func _on_pause_button_pressed() -> void:
	PauseScreen.show()
	PauseScreen.pause()
	


func _on_hint_button_pressed() -> void:
	if HintsLeft > 0:
		var CurrentCamPos = CameraSystem.CurrentPosition
	
		if CurrentCamPos == 0: #Middle
			if MiddlePainting.CurrentState == MiddlePainting.PaintingState.Sabotage1:
				Dialogic.VAR.HintNumber = str(rng.randi_range(1, 3))
				Dialogic.start("PaintingOneSabotageOne")
			elif MiddlePainting.CurrentState == MiddlePainting.PaintingState.Sabotage2:
				Dialogic.VAR.HintNumber = str(rng.randi_range(1, 3))
				Dialogic.start("PaintingOneSabotageTwo")
			elif MiddlePainting.CurrentState == MiddlePainting.PaintingState.Sabotage3:
				Dialogic.VAR.HintNumber = str(rng.randi_range(1, 3))
				Dialogic.start("PaintingOneSabotageThree")
			elif MiddlePainting.CurrentState == MiddlePainting.PaintingState.Sabotage4:
				Dialogic.VAR.HintNumber = str(rng.randi_range(1, 3))
				Dialogic.start("PaintingOneSabotageFour")
			else:
				Dialogic.start("PaintingOneRest")
		
		HintsLeft -=1
		HintLabel.text = str(HintsLeft)

func _on_right_visibility_changed() -> void:
	if RightNotice.visible == true:
		SFXPlayer.PlayRandomSound()


func _on_left_visibility_changed() -> void:
	if LeftNotice.visible == true:
		SFXPlayer.PlayRandomSound()
