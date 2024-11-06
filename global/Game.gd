extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


var dataBaseMonsters = {
	1: {
		"Name": "Minotaur",
		"Frame": 0,
		"Health": 10,
		"Level": 1,
		"Exp": 0,
		"MaxExp": 0,
		"Defense": 0,
		"Scene": preload("res://Monsters/minotaur.tscn"), # placeholder
		"Attacks": {
			0: {
				"Name": "Slash",
				"Target":"Player",
				"Damage": 150, 
				"Type": "Physical",
				"cost": 2,
			},
			1: {
				"Name": "Ram",
				"Target":"Player",
				"Damage": 200, 
				"Type": "Physical",
				"cost": 2,
			},
			2: {
				"Name": "Throw Rock",
				"Target":"Player",
				"Damage": 50, 
				"Type": "Ranged",
				"cost": 2,
			}
		}
	},
	2: {
		"Name": "",
		"Frame": 0,
		"Health": 100,
		"Level": 1,
		"Exp": 0,
		"MaxExp": 0,
		"Defense": 5,
		"Scene": preload("res://icon.svg"), # placeholder
		"Attacks": {
			0: {
				"Name": "Blast",
				"Target":"Player",
				"Damage": 10, 
				"cost": 2,
			},
			1: {
				"Name": "Clash",
				"Target":"Player",
				"Damage": 10, 
				"cost": 2,
			},
			2: {
				"Name": "Impact",
				"Target":"Player",
				"Damage": 10, 
				"cost": 2,
			}
		}
	},
	3: {
		"Name": "",
		"Frame": 0,
		"Health": 100,
		"Level": 1,
		"Exp": 0,
		"MaxExp": 0,
		"Defense": 5,
		"Scene": preload("res://icon.svg"), # placeholder
		"Attacks": {
			0: {
				"Name": "Blast",
				"Target":"Player",
				"Damage": 10, 
				"cost": 2,
			},
			1: {
				"Name": "Clash",
				"Target":"Player",
				"Damage": 10, 
				"cost": 2,
			},
			2: {
				"Name": "Impact",
				"Target":"Player",
				"Damage": 10, 
				"cost": 2,
			}
		}
	}
	
}

var selectedMonsters = {
	0: {
		"Name": "Player",
		"Frame": 0,
		"Health": 100,
		"Level": 1,
		"Exp": 0,
		"MaxExp": 10,
		"Defense": 10,
		"Scene": preload("res://Player/player.tscn"), # placeholder
		"Attacks": {
			0: {
				"Name": "Sword",
				"Target":"Monster",
				"Damage": 25, 
				"Type": "Physical",
				"cost": 2,
			},
			1: {
				"Name": "Bow",
				"Target":"Monster",
				"Damage": 18, 
				"Type": "Ranged",
				"cost": 2,
			},
			2: {
				"Name": "Magic",
				"Target":"Monster",
				"Damage": 45, 
				"Type": "Magic",
				"cost": 2,
			}
		}
	}
}

func addEXP(amount):
	while selectedMonsters[0]["Exp"] >= selectedMonsters[0]["MaxExp"]:
		#LEVEL UP
		selectedMonsters[0]["Level"] += 1
		selectedMonsters[0]["Exp"] = int(selectedMonsters[0]["Exp"]) - int(selectedMonsters[0]["MaxExp"])
		selectedMonsters[0]["MaxExp"] = selectedMonsters[0]["MaxExp"] * 1.25
	
#Atk / (Def+100 / 100)
func calculate_damage(defense: int, attack_power: int, level: int) -> int:
	
	# Apply defense mitigation, so higher defense reduces incoming damage
	var damage = max(attack_power/(defense+100/100), 1)  # Ensure at least 1 damage
	
	# Round damage to an integer for final output
	return int(damage)

func calculate_attack_power(base_attack_power: int, level: int) -> int:
	var scaled_attack_power = base_attack_power * (1 + level / 20.0)
	return int(scaled_attack_power + randi_range(0, level / 2))

func calculate_defense(level: int) -> int:
	# Calculate defense using a quadratic formula, capped at 50 and starting from 0 at level 1
	var defense = int(pow(level - 1, 2) * 0.5)  # Quadratic growth starting from level 1
	return min(defense, 50)  # Cap defense at 50
