extends Node2D

@onready var camera = $Camera2D

@onready var buttonGroup = $Buttons
@onready var LeftButton = $Buttons/LeftButton
@onready var RightButton = $Buttons/RightButton

var CamMiddlePos = Vector2(0.0, 0.0)
var CamLeftPos = Vector2(-1920.0, 0.0)
var CamRightPos = Vector2(1920.0, 0.0)
var CamFarRightPos = Vector2(4000.0, 0.0)
var CamFarLeftPos = Vector2(-4000.0, 0.0)

enum Position {
	Middle,
	Left,
	Right,
	FarLeft,
	FarRight
}

var CurrentPosition = Position.Middle

func _process(delta: float) -> void:
	if CurrentPosition == Position.FarLeft:
		LeftButton.visible = false
		RightButton.visible = true
		
	elif CurrentPosition == Position.FarRight:
		RightButton.visible = false
		LeftButton.visible = true
		
	else:
		LeftButton.visible = true
		RightButton.visible = true


func _on_right_button_pressed() -> void:
	match CurrentPosition:
		Position.FarLeft:
			$AnimationPlayer.play("BlackFade")
			await $AnimationPlayer.animation_finished
			camera.position = CamLeftPos
			CurrentPosition = Position.Left
			await get_tree().create_timer(.5).timeout
			$AnimationPlayer.play_backwards("BlackFade")
			
		Position.Left:
			camera.position = CamMiddlePos
			CurrentPosition = Position.Middle
			
		Position.Middle:
			camera.position = CamRightPos
			CurrentPosition = Position.Right
			
		Position.Right:
			$AnimationPlayer.play("BlackFade")
			await $AnimationPlayer.animation_finished
			camera.position = CamFarRightPos
			CurrentPosition = Position.FarRight
			await get_tree().create_timer(.5).timeout
			$AnimationPlayer.play_backwards("BlackFade")


func _on_left_button_pressed() -> void:
	match CurrentPosition:
		Position.FarRight:
			$AnimationPlayer.play("BlackFade")
			await $AnimationPlayer.animation_finished
			camera.position = CamRightPos
			CurrentPosition = Position.Right
			await get_tree().create_timer(.5).timeout
			$AnimationPlayer.play_backwards("BlackFade")
			
		Position.Right:
			camera.position = CamMiddlePos
			CurrentPosition = Position.Middle
			
		Position.Middle:
			camera.position = CamLeftPos
			CurrentPosition = Position.Left
			
		Position.Left:
			$AnimationPlayer.play("BlackFade")
			await $AnimationPlayer.animation_finished
			camera.position = CamFarLeftPos
			CurrentPosition = Position.FarLeft
			await get_tree().create_timer(.5).timeout
			$AnimationPlayer.play_backwards("BlackFade")
