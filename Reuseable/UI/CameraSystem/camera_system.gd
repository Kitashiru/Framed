extends Node2D

@onready var camera = $Camera2D
@onready var LeftButton = $CanvasLayer/LeftButton
@onready var RightButton = $CanvasLayer/RightButton
var CamMiddlePos = Vector2(0.0, 0.0)
var CamLeftPos = Vector2(-1920.0, 0.0)
var CamRightPos = Vector2(1920.0, 0.0)


var CurrentPosition = Position.Middle
enum Position {
	Middle,
	Left,
	Right
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if CurrentPosition == Position.Left:
		LeftButton.visible = false
		RightButton.visible = true
	elif CurrentPosition == Position.Right:
		RightButton.visible = false
		LeftButton.visible = true
	else:
		RightButton.visible = true
		LeftButton.visible = true


func _on_left_button_pressed() -> void:
	if CurrentPosition == Position.Middle:
		camera.position = CamLeftPos
		CurrentPosition = Position.Left
	if CurrentPosition == Position.Right:
		camera.position = CamMiddlePos
		CurrentPosition = Position.Middle


func _on_right_button_pressed() -> void:
	if CurrentPosition == Position.Middle:
		camera.position = CamRightPos
		CurrentPosition = Position.Right
	if CurrentPosition == Position.Left:
		camera.position = CamMiddlePos
		CurrentPosition = Position.Middle
