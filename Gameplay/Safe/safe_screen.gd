extends Node2D

@onready var Key0 = $Key0
@onready var Key1 = $Key1
@onready var Key2 = $Key2
@onready var Key3 = $Key3
@onready var Key4 = $Key4
@onready var Key5 = $Key5
@onready var Key6 = $Key6
@onready var Key7 = $Key7
@onready var Key8 = $Key8
@onready var Key9 = $Key9
@onready var BackKey = $BackSpace
@onready var EnterKey = $Enter

@onready var KeyButtons = [
	Key0, Key1, Key2, Key3, Key4, Key5, Key6, Key7, Key8, Key9, BackKey,EnterKey 
]

@onready var CodeLabel = $Safe/CodeLable
@onready var SafeSprite = $Safe/SafeSprite

@onready var Book = $Book
@onready var PaintingInfo = $PaintingInfo
@onready var ClosePaintingInfo = $PaintingInfo/ClosePaintingInfo

var GirlWithPearlBookPath = "res://Assets/SafeScreen/girl_with_pearl_book.png"
var ScreamBookPath = "res://Assets/SafeScreen/scream_book.png"
var AmericanGothicBookPath = "res://Assets/SafeScreen/american_gothic_book.png"

var BookImages = [
	GirlWithPearlBookPath,
	ScreamBookPath,
	AmericanGothicBookPath
]

var CurrentBookIndex : int = 0

var CorrectCode : String = "4415"

var CurrentCode : String = ""


func _ready() -> void:
	pass

func add_digit(digit: int) -> void:
	if CurrentCode.length() < 4:
		CurrentCode += str(digit)
		print("CurrentCode:", CurrentCode)
		UpdateLabel()

func check_code() -> void:
	if CurrentCode == CorrectCode:
		print("Code correct! Unlocking...")
		hide_all_keys()
		SafeSprite.texture = load("res://Assets/SafeScreen/safe_box_transp_open.png")
		Book.visible = true
	else:
		print("Incorrect code!")
		CurrentCode = ""
		UpdateLabel()

func hide_all_keys():
	for key in KeyButtons:
		key.visible = false
	CodeLabel.hide()
	
func _on_key_0_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		add_digit(0)

func _on_key_1_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		add_digit(1)

func _on_key_2_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		add_digit(2)

func _on_key_3_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		add_digit(3)

func _on_key_4_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		add_digit(4)

func _on_key_5_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		add_digit(5)

func _on_key_6_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		add_digit(6)

func _on_key_7_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		add_digit(7)

func _on_key_8_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		add_digit(8)

func _on_key_9_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		add_digit(9)

func _on_back_space_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if CurrentCode.length() > 0:
			CurrentCode = CurrentCode.substr(0, CurrentCode.length() - 1)
			UpdateLabel()
			print("CurrentCode:", CurrentCode)


func _on_enter_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		check_code()

func UpdateLabel():
	CodeLabel.text = CurrentCode


func _on_book_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		PaintingInfo.visible = true



func _on_close_painting_info_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		PaintingInfo.visible = false


func _on_right_button_pressed() -> void:
	CurrentBookIndex -= 1
	if CurrentBookIndex < 0:
		CurrentBookIndex = BookImages.size() - 1
	update_book_image()


func _on_left_button_pressed() -> void:
	CurrentBookIndex += 1
	if CurrentBookIndex >= BookImages.size():
		CurrentBookIndex = 0
	update_book_image()

func update_book_image() -> void:
	PaintingInfo.texture = load(BookImages[CurrentBookIndex])
