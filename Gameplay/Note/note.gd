extends Node2D

@onready var NoteLayer = $CanvasLayer
@onready var collisionshape = $Area2D/CollisionPolygon2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left_click"):
		NoteLayer.show()
		collisionshape.disabled = true

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if NoteLayer.visible:
			NoteLayer.hide()
			await get_tree().create_timer(0.2).timeout
			collisionshape.disabled = false
