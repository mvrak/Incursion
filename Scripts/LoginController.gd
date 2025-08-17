extends Control

@onready var login_button = $WebFrame
@onready var status_label = $StatusLabel
@onready var wallet_address_label = $WalletAddress

var wallet_address: String = ""
var is_logged_in: bool = false

func _ready():
	# Connect the login button signal
	login_button.pressed.connect(_on_login_button_pressed)
	status_label.text = "Press 'Login with Privy' to start."
	wallet_address_label.text = "Wallet: Not connected"

func _on_login_button_pressed():
	if not is_logged_in:
		# Simulate Privy login for demo
		status_label.text = "Logging in..."
		var login_timer = Timer.new()
		add_child(login_timer)
		login_timer.wait_time = 2.0  # Shorter delay for demo
		login_timer.one_shot = true
		login_timer.timeout.connect(_simulate_login)
		login_timer.start()

func _simulate_login():
	# Mock wallet address for demo
	wallet_address = "0x742d35Cc6634C0532925a3b8D4C9db96C4b4d8b6"
	wallet_address_label.text = "Wallet: " + wallet_address
	status_label.text = "Login successful! Redirecting to game..."
	is_logged_in = true
	
	# Transition to game
	var transition_timer = Timer.new()
	add_child(transition_timer)
	transition_timer.wait_time = 1.0
	transition_timer.one_shot = true
	transition_timer.timeout.connect(_transition_to_game)
	transition_timer.start()

func _transition_to_game():
	# Store wallet address in global singleton
	if GlobalGameData:
		GlobalGameData.wallet_address = wallet_address
	else:
		push_error("GlobalGameData not found. Ensure it's set as an autoload.")
	
	# Change to dungeon scene
	if ResourceLoader.exists("res://Scenes/Dungeon.tscn"):
		get_tree().change_scene_to_file("res://Scenes/Dungeon.tscn")
	else:
		push_error("Dungeon.tscn not found. Check file path.")
