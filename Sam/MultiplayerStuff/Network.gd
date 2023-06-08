extends Node


const DEFAULT_PORT = 28960
const MAX_CLIENTS = 6

var server = null
var client = null

var ip_address = ""

func _ready():
	# Gets IPs
	if OS.get_name() == "Windows":
		ip_address = IP.get_local_addresses()[3]
	elif OS.get_name() == "Mac OS X":
		var ip_address = ""
		var ip = IP.new()
		var addresses = ip.get_local_addresses()

		if addresses.size() >= 4:
			ip_address = addresses[3]

		print(ip_address)
	
	for ip in IP.get_local_addresses():
		if ip.begins_with("192.168."):
			ip_address = ip
	
	# looks for connection or disconnection
	get_tree().connect("connected_to_server", self, "_connected_to_server")
	get_tree().connect("server_disconnected", self, "_server_disconnected")

# Makes server using assigned variables
func create_server() -> void:
	server = NetworkedMultiplayerENet.new()
	server.create_server(DEFAULT_PORT, MAX_CLIENTS)
	
	# Tells tree that we are using enet
	get_tree().set_network_peer(server)

# Join the server
func join_server() -> void:
	client = NetworkedMultiplayerENet.new()
	client.create_client(ip_address, DEFAULT_PORT)
	
	# Tells tree that we are using enet
	get_tree().set_network_peer(client)

# Prints if connected or disconnected
func _connected_to_server() -> void:
	print("Successfully connected to the server")
func _server_disconnected() -> void:
	print("Disconnected from the server")
