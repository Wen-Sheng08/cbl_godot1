extends Node2D

var l_actions = [
	"move",
	"load_game"
]

var turn = 0
@export var currentAction = "move"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _refresh_round():
	currentAction = "move"
	_next_action()
	pass

func _allowMove():
	if self.canMove == false:
		self.canMove = true	

func _loadGame():
	#load scene
	pass

func _next_action():
	if currentAction == "move":
		_allowMove()
	elif currentAction == "load_game":
		_loadGame()
