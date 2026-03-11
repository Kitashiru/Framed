extends Node2D

@onready var CameraSystem = $CameraSystem
@onready var LeftNotice = $CanvasLayer/Left
@onready var RightNotice = $CanvasLayer/Right

@onready var LeftPainting = $PaintingTwo
@onready var MiddlePainting = $PaintingOne
@onready var RightPainting = $PaintingThree

@onready var PauseScreen = $PauseScreen

var PaintingList = []

var rng = RandomNumberGenerator.new()

var CurrentTime = 1
var LastUpdatedTime

var score = 0
var LastUpdatedScore
@onready var ScoreLabel = $CanvasLayer/ScoreLabel

@onready var TimeLabel = $CanvasLayer/Label

@onready var EventTimer = $EventTimer
@export var MinimumEventTime:int
@export var MaximumEventTime:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var random_time = rng.randi_range(MinimumEventTime, MaximumEventTime)
	EventTimer.wait_time = random_time
	EventTimer.start()
	PaintingList = [MiddlePainting, LeftPainting, RightPainting]

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
			LeftPainting.ChangeToMischievous()
			LeftNotice.visible = true
			await get_tree().create_timer(2).timeout
			LeftNotice.visible = false
		if random == 2:
			RightPainting.ChangeToMischievous()
			RightNotice.visible = true
			await get_tree().create_timer(2).timeout
			RightNotice.visible = false

	elif CurrentCamPos == 1: #Left
		var random = rng.randi_range(1, 2) # 1=Middle 2=Right
		if random == 1:
			MiddlePainting.ChangeToMischievous()
			MiddlePainting.StartSabatogeTimer(true)
		else:
			RightPainting.ChangeToMischievous()
		RightNotice.visible = true
		await get_tree().create_timer(2).timeout
		RightNotice.visible = false

	elif CurrentCamPos == 2: #Right
		var random = rng.randi_range(1, 2) # 1=Middle 2=Left
		if random == 1:
			MiddlePainting.ChangeToMischievous()
		else:
			LeftPainting.ChangeToMischievous()
		LeftNotice.visible = true
		await get_tree().create_timer(2).timeout
		LeftNotice.visible = false


func _on_timer_timeout() -> void:
	CurrentTime += 0.5
	if CurrentTime == 6:
		pass


func _on_pause_button_pressed() -> void:
	PauseScreen.show()
	PauseScreen.pause()
	
