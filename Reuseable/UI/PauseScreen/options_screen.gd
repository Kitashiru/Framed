extends CanvasLayer

signal Resumed

@onready var MasterSlider = $VBoxContainer/TextureRect2/MasterVolumeSlider
@onready var SFXSlider = $VBoxContainer/TextureRect2/SFXVolumeSlider
@onready var MusicSlider = $VBoxContainer/TextureRect2/MusicVolumeSlider

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MasterSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	SFXSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))
	MusicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func resume():
	get_tree().paused = false
	visible = false
func pause():
	get_tree().paused = true


func _on_back_button_pressed() -> void:
	visible = false
	emit_signal("Resumed")

func _on_master_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))


func _on_sfx_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))


func _on_music_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))
