extends Node2D

var l_actions = [
	"move",
	"load_game"
]

const minigames = {
	"cooking" : preload("res://scenes/mg_cooking.tscn"),
	"transport" : preload("res://scenes/mg_transport.tscn"),
	"sport" : preload("res://scenes/mg_sport.tscn"),
	}

var turn = 0
@export var currentAction = "move"
@onready var main_map = $MainMap
@onready var player = $MainMap/Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for obj in get_tree().get_nodes_in_group("clickable_cstm"):
		print(obj)
		obj.clicked.connect(player.move_to)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _load_minigame(coll):
	var tag = coll.get_parent().get_meta("minigame") if coll.get_parent() else ""
	print("Finding game..." + tag)
	if minigames.has(tag):
		print("Loading minigame: " + tag)
		var instance_mg = minigames[tag].instantiate()
		#instance_mg.finished.connect(end_minigame)
		main_map.visible = false
		main_map.process_mode = Node.PROCESS_MODE_DISABLED
		add_child(instance_mg)
	elif tag not in minigames:
		print("Game not found.")
