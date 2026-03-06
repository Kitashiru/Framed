extends Node2D

@onready var SabatogeTimer = $SabatogeTimer
@onready var ResetTimer = $ResetTimer


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
	pass


func ChangeToMischievous() -> void:
	CurrentState = PaintingState.Mischievous
	
func ChangeToSabatoge() -> void:
	CurrentState = PaintingState.Sabatoge

func StartSabatogeTimer(Running: bool) -> void:
	SabatogeTimer.paused = Running
	ResetTimer.start()
	ResetTimer.paused = true

func StartResetTimer(Running: bool) -> void:
	ResetTimer.paused = Running

func _on_reset_timer_timeout() -> void:
	CurrentState = PaintingState.Rest


func _on_sabatoge_timer_timeout() -> void:
	CurrentState = PaintingState.Sabatoge
