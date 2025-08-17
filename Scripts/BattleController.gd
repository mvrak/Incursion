extends Node2D

@onready var player = $Player
@onready var enemy = $Enemy
@onready var player_health_bar = $UI/PlayerHealthBar
@onready var enemy_health_bar = $UI/EnemyHealthBar
@onready var battle_log = $UI/BattleLog
@onready var loot_drop = $LootDrop

var player_health: int = 100
var player_max_health: int = 100
var enemy_health: int = 80
var enemy_max_health: int = 80
var is_player_turn: bool = true
var battle_active: bool = true

func _ready():
	# Initialize battle
	player_health = GlobalGameData.player_health
	player_max_health = GlobalGameData.player_max_health
	update_health_bars()
	
	# Update wallet info
	var wallet_info = $UI/WalletInfo
	if wallet_info:
		var wallet = GlobalGameData.wallet_address
		if wallet != "":
			wallet_info.text = "Wallet: " + wallet
		else:
			wallet_info.text = "Wallet: Not connected"
	
	# Start battle sequence
	start_battle()

func start_battle():
	battle_log.text = "Battle begins! You face a fearsome enemy!"
	await get_tree().create_timer(2.0).timeout
	
	if is_player_turn:
		player_turn()
	else:
		enemy_turn()

func player_turn():
	is_player_turn = false
	battle_log.text = "Your turn! Press SPACE to attack!"
	
	# Wait for player input
	await get_tree().create_timer(3.0).timeout
	
	# Player attack
	var damage = randi_range(15, 25)
	enemy_health -= damage
	enemy_health = max(0, enemy_health)
	
	battle_log.text = "You deal " + str(damage) + " damage!"
	update_health_bars()
	
	# Check if enemy is defeated
	if enemy_health <= 0:
		enemy_defeated()
		return
	
	# Enemy turn
	enemy_turn()

func enemy_turn():
	is_player_turn = true
	battle_log.text = "Enemy's turn!"
	await get_tree().create_timer(1.5).timeout
	
	# Enemy attack
	var damage = randi_range(10, 20)
	player_health -= damage
	player_health = max(0, player_health)
	
	battle_log.text = "Enemy deals " + str(damage) + " damage!"
	update_health_bars()
	
	# Check if player is defeated
	if player_health <= 0:
		player_defeated()
		return
	
	# Continue battle
	player_turn()

func update_health_bars():
	player_health_bar.value = (float(player_health) / float(player_max_health)) * 100
	enemy_health_bar.value = (float(enemy_health) / float(enemy_max_health)) * 100

func enemy_defeated():
	battle_active = false
	battle_log.text = "Enemy defeated! Victory!"
	
	# Drop loot
	drop_loot()
	
	# Award experience
	var exp_gained = 50
	GlobalGameData.player_experience += exp_gained
	battle_log.text += "\nGained " + str(exp_gained) + " experience!"
	
	# Save game data
	GlobalGameData.save_game_data()
	
	# Return to main menu after delay
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://Scenes/Login.tscn")

func player_defeated():
	battle_active = false
	battle_log.text = "You have been defeated! Game Over!"
	
	# Reset game data
	GlobalGameData.reset_game_data()
	
	# Return to main menu after delay
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://Scenes/Login.tscn")

func drop_loot():
	# Create a sword drop
	var sword = preload("res://Scenes/SwordDrop.tscn").instantiate()
	add_child(sword)
	sword.position = enemy.position
	
	# Award NFT to wallet
	award_nft()

func award_nft():
	# Use Web3 integration to mint NFT
	var wallet = GlobalGameData.wallet_address
	if wallet != "":
		# Generate unique token ID
		var token_id = randi()
		var token_uri = "https://api.example.com/metadata/" + str(token_id)
		
		# Mint NFT using Web3 integration
		var web3 = get_node("/root/Web3Integration")
		if web3:
			web3.mint_nft(token_id, token_uri, wallet)
			battle_log.text += "\nNFT 'Victory Sword' minted to " + wallet
		else:
			battle_log.text += "\nNFT 'Victory Sword' sent to " + wallet
			print("NFT 'Victory Sword' awarded to wallet: ", wallet)
	else:
		battle_log.text += "\nNo wallet connected for NFT reward"

func _input(event):
	if event.is_action_pressed("ui_accept") and battle_active and is_player_turn:
		player_turn()
