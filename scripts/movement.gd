extends Node2D

var tween = Tween
var layer
var player
@export var canMove = true

enum StateNum {WAITING_FOR_MOVE, IN_MOVE, MINIGAME}
var state = StateNum.WAITING_FOR_MOVE
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = $Player
	layer = $TileMapLayer
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _moved():
	self.currentAction = "load_game"

func _input(event):
	if event is InputEventMouseButton and canMove:
		if state != StateNum.WAITING_FOR_MOVE:
			print("returned")
			return
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT and player and layer:
			print("pressed")
			var cell = layer.local_to_map(layer.to_local(get_global_mouse_position()))
		# Ignore clicks on empty cells (no tile painted there)
			if layer.get_cell_source_id(cell) == -1:
				return
			
			state = StateNum.IN_MOVE
			var target = layer.to_global(layer.map_to_local(cell))
			
			tween = create_tween()
			tween.tween_property(player, "global_position", target, 0.4)\
			.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
			tween.finished.connect(_on_arrived.bind(cell))
			
func _on_arrived(cell):
	var data = layer.get_cell_tile_data(cell)
	var path = data.get_custom_data("minigame") if data else ""
	
	if path == "":
		_end_turn()
		return
	
	state = StateNum.MINIGAME
	var minigame = load(path).instantiate()
	add_child(minigame)
	minigame.finished.connect(_on_minigame_finished.bind())
	
func _on_minigame_finished(won: bool, minigame: Node):
	minigame.queue_free()
	#apply the result here
	_end_turn()

func _end_turn():
	state = StateNum.WAITING_FOR_MOVE
