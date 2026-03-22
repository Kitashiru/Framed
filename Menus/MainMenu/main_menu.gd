extends Control

@onready var animationPlayer = $AnimationPlayer

var clicked = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animationPlayer.play("RESET")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if not clicked and event.is_action_pressed("left_click"):
		animationPlayer.play("Click")
		clicked = true


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Gameplay/DefaultNight/DefaultNight.tscn")


func _on_options_button_pressed() -> void:
	animationPlayer.play("ShowOptions")


func _on_credits_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_back_button_pressed() -> void:
	animationPlayer.play_backwards("ShowOptions")
