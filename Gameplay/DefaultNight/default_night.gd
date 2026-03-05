extends Node2D

var CurrentTime = 1
var LastUpdatedTime
@onready var TimeLabel = $CanvasLayer/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if LastUpdatedTime != CurrentTime:
		TimeLabel.text = ChangeTimeToString(CurrentTime)
		LastUpdatedTime = CurrentTime


func _on_timer_timeout() -> void:
	CurrentTime += 0.5

func ChangeTimeToString(time: float) -> String:
	if not ".5" in str(time):
		return str(int(time)) + ":00"
	else:
		return str(int(time - .5)) + ":30"
