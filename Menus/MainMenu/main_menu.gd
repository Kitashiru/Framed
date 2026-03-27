extends Control

@onready var animationPlayer = $AnimationPlayer
@onready var MasterSlider = $CanvasLayer/TextureRect2/MasterVolumeSlider
@onready var SFXSlider = $CanvasLayer/TextureRect2/SFXVolumeSlider
@onready var MusicSlider = $CanvasLayer/TextureRect2/MusicVolumeSlider

var clicked = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animationPlayer.play("RESET")
	MasterSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	SFXSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))
	MusicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))

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


func _on_master_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))


func _on_sfx_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))


func _on_music_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))
