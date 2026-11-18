extends Node2D

var tween = Tween

enum StateNum {WAITING_FOR_MOVE, IN_MOVE, MINIGAME}
var state = StateNum.WAITING_FOR_MOVE
# Called when the node enters the scene tree for the first time.
func move_to(target):
	if state != StateNum.WAITING_FOR_MOVE:
		return
	
	state = StateNum.IN_MOVE
	
	tween = create_tween()
	tween.tween_property(self, "global_position", target.global_position, 0.5) \
	.set_trans(Tween.TRANS_SINE) \
	.set_trans(Tween.EASE_IN_OUT)
	tween.finished.connect(_on_arrived.bind(target))

func _on_arrived(tag):
	get_tree().current_scene._load_minigame(tag)
	pass
