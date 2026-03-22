extends AudioStreamPlayer

var sounds = [
	"res://Assets/SFX/BoxDropping2.wav",
	"res://Assets/SFX/BoxDropping3.wav",
	"res://Assets/SFX/BoxDropping4.wav",
	"res://Assets/SFX/BoxDropping5.wav",
	"res://Assets/SFX/BoxDropping6.wav",
	"res://Assets/SFX/BoxDropping7.wav",
	"res://Assets/SFX/BoxDropping8.wav",
	"res://Assets/SFX/BoxDropping9.wav",
	"res://Assets/SFX/BoxDropping10.wav",
	"res://Assets/SFX/BoxDropping11.wav",
	"res://Assets/SFX/BoxDropping12.wav",
	"res://Assets/SFX/BoxDropping13.wav",
	"res://Assets/SFX/BoxDropping14.wav",
	"res://Assets/SFX/BoxDropping15.wav",
	"res://Assets/SFX/BoxDropping16.wav",
	"res://Assets/SFX/BoxDropping17.wav",
	"res://Assets/SFX/BoxDropping18.wav",
	"res://Assets/SFX/BoxDropping19.wav",
	"res://Assets/SFX/CupRollingFloor1.wav",
	"res://Assets/SFX/CupRollingFloor2.wav",
	"res://Assets/SFX/CupRollingFloor3.wav",
	"res://Assets/SFX/CupRollingFloor4.wav",
	"res://Assets/SFX/CupRollingFloor5.wav",
	"res://Assets/SFX/CupRollingTable1.wav",
	"res://Assets/SFX/CupRollingTable2.wav",
	"res://Assets/SFX/CupRollingTable3.wav",
	"res://Assets/SFX/CupRollingTable4.wav",
	"res://Assets/SFX/CupRollingTable5.wav",
	"res://Assets/SFX/CupRollingTable6.wav",
	"res://Assets/SFX/CupRollingTable7.wav",
	"res://Assets/SFX/CupRollingTable8.wav",
	"res://Assets/SFX/CupRollingTable9.wav",
	"res://Assets/SFX/GlassCrack1.wav"
]

func _ready() -> void:
	pass

func PlayRandomSound():
	var sound = load(sounds.pick_random())
	stream = sound
	play()
