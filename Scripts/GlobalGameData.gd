extends Node

# Global game data that persists between scenes
var wallet_address: String = ""
var player_health: int = 100
var player_max_health: int = 100
var player_level: int = 1
var player_experience: int = 0
var player_gold: int = 0

# Inventory and equipment
var inventory: Array = []
var equipped_weapon: String = ""
var equipped_armor: String = ""

# Game progress
var current_quest: String = ""
var quest_progress: int = 0
var completed_quests: Array = []

# Battle state
var in_battle: bool = false
var current_enemy: String = ""
var enemy_health: int = 0

func _ready():
	# This script should be added as an autoload in Project Settings
	pass

func reset_game_data():
	wallet_address = ""
	player_health = 100
	player_max_health = 100
	player_level = 1
	player_experience = 0
	player_gold = 0
	inventory.clear()
	equipped_weapon = ""
	equipped_armor = ""
	current_quest = ""
	quest_progress = 0
	completed_quests.clear()
	in_battle = false
	current_enemy = ""
	enemy_health = 0

func save_game_data():
	# Save game data to file
	var save_data = {
		"wallet_address": wallet_address,
		"player_health": player_health,
		"player_max_health": player_max_health,
		"player_level": player_level,
		"player_experience": player_experience,
		"player_gold": player_gold,
		"inventory": inventory,
		"equipped_weapon": equipped_weapon,
		"equipped_armor": equipped_armor,
		"current_quest": current_quest,
		"quest_progress": quest_progress,
		"completed_quests": completed_quests
	}
	
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	if save_file:
		save_file.store_string(JSON.stringify(save_data))
		save_file.close()

func load_game_data():
	# Load game data from file
	if FileAccess.file_exists("user://savegame.save"):
		var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
		if save_file:
			var save_data = JSON.parse_string(save_file.get_as_text())
			save_file.close()
			
			if save_data:
				wallet_address = save_data.get("wallet_address", "")
				player_health = save_data.get("player_health", 100)
				player_max_health = save_data.get("player_max_health", 100)
				player_level = save_data.get("player_level", 1)
				player_experience = save_data.get("player_experience", 0)
				player_gold = save_data.get("player_gold", 0)
				inventory = save_data.get("inventory", [])
				equipped_weapon = save_data.get("equipped_weapon", "")
				equipped_armor = save_data.get("equipped_armor", "")
				current_quest = save_data.get("current_quest", "")
				quest_progress = save_data.get("quest_progress", 0)
				completed_quests = save_data.get("completed_quests", [])
