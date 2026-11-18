extends Control

@export var Adress = "127.0.0.1"
@export var port = 8910

var peer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#this func gets called on the server AND clients, when someone connects.
func peer_connected(id):
	print("Player connected" + str(id))
	

#this func gets called on the server AND clients, when someone disconnects
func peer_disconnected(id):
	print("Player disconnected" + str(id))

#only gets called from clients
func connected_to_server():
	print("Connected to server!")

#only gets called from clients
func connection_failed():
	print("Connection Failed")

@rpc("any_peer","call_local")
func startGameClient():
	var scene = load("res://button_swipe.gd")
	get_tree().root.add_child(scene)
	self.hide()

#creates a host server (eg. big screen) that will communicate with the client devices
func _on_host_button_down():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, 4)
	if error != OK:
		print("Can't host: " + error)
		return
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	
	multiplayer.set_multiplayer_peer(peer)
	print("waiting for players...")
	
	pass # Replace with function body.

#creates a client for the server
func _on_player_button_down():
	peer = ENetMultiplayerPeer.new()
	peer.create_client(Adress, port)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)
	
	pass # Replace with function body.


func _on_start_button_down():
	startGameClient.rpc()
	pass # Replace with function body.
