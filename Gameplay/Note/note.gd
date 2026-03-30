extends Node2D

@onready var NoteLayer = $CanvasLayer
@onready var collisionshape = $Area2D/CollisionShape2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		if NoteLayer.visible == true:
			NoteLayer.hide()
			await get_tree().create_timer(0.5).timeout
			collisionshape.disabled = false


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left_click"):
		NoteLayer.show()
		collisionshape.disabled = true
