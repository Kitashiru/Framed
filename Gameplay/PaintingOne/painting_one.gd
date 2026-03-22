extends Node2D

@onready var SabatogeTimer = $SabatogeTimer
@onready var ResetTimer = $ResetTimer
@onready var StateLabel = $StateLabel
@onready var PaintingSprite = $Painting
@onready var animationplayer = $AnimationPlayer

var points = 0

var baseImgPath = "res://Assets/PaintingOne/base_girl_with_pearl_earring.png"
var ImgFolderPath = "res://Assets/PaintingOne/"

var rng = RandomNumberGenerator.new()

enum PaintingState{
	Rest,
	Mischievous,
	Sabatoge
}

var CurrentState = PaintingState.Rest


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	StateLabel.text = PaintingState.keys()[CurrentState]
	pass


func ChangeToMischievous() -> void:
	CurrentState = PaintingState.Mischievous
	
func ChangeToSabatoge() -> void:
	CurrentState = PaintingState.Sabatoge

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
	CurrentState = PaintingState.Sabatoge
	var randomimg = rng.randi_range(1, 4)
	PaintingSprite.texture = load(ImgFolderPath + "sab" + str(randomimg) + "_girl_with_pearl_earring.png")
	ResetTimer.stop()
	SabatogeTimer.stop()

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_click"): # 'left_click' should be set up in Project Settings
		#print("2D object clicked!")
		$SabotageMenu.visible = true

func _on_check_button_pressed() -> void:
	if CurrentState == PaintingState.Sabatoge:
		CurrentState = PaintingState.Rest
		PaintingSprite.texture = load(baseImgPath)
		points += 50
		SabatogeTimer.stop()
	else:
		points -= 50
	$SabotageMenu.visible = false


func _on_close_button_pressed() -> void:
	$SabotageMenu.visible = false


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
