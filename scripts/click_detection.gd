extends Area2D

signal clicked(target)

@onready var root = get_tree()

func _ready():
	add_to_group("clickable_cstm")
# Called when the node enters the scene tree for the first time.
func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		clicked.emit(self)
