extends Button

var persona = [
	"Gerald",
	"Mary",
	"Luke",
	"Emma"
]
var cycle = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_down():
	cycle = wrapi(cycle+1, 0, persona.size())
	$"../Name".text = persona[cycle]
	print(cycle)
	pass # Replace with function body.
