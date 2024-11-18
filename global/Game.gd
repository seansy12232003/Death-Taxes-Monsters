extends Node

# Base values
var base_exp = 10  # Base EXP for level 1 monsters
var growth_factor = 1.2  # Growth factor for scaling EXP per monster
var level_multiplier = 1.5  # Multiplier for EXP to level up

# selected monster, or encountered monster ID, change when encountering other monsters
var selected

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
		"Weakness": "Magic",
		"Scene": preload("res://Monsters/minotaur.tscn"), # placeholder
		"Attacks": {
			0: {
				"Name": "Slash",
				"Target":"Player",
				"Damage": 15, 
				"Type": "Physical",
				"cost": 2,
			},
			1: {
				"Name": "Ram",
				"Target":"Player",
				"Damage": 20, 
				"Type": "Physical",
				"cost": 2,
			},
			2: {
				"Name": "Throw Rock",
				"Target":"Player",
				"Damage": 5, 
				"Type": "Ranged",
				"cost": 2,
			}
		}
	},
	2: {
		"Name": "Wolf",
		"Frame": 0,
		"Health": 10,
		"Level": 5,
		"Exp": 0,
		"MaxExp": 0,
		"Defense": 0,
		"Weakness": "Magic",
		"Scene": preload("res://Monsters/minotaur.tscn"), # placeholder
		"Attacks": {
			0: {
				"Name": "Slash",
				"Target":"Player",
				"Damage": 10, 
				"Type": "Physical",
				"cost": 2,
			},
			1: {
				"Name": "Bite",
				"Target":"Player",
				"Damage": 20, 
				"Type": "Physical",
				"cost": 2,
			},
			2: {
				"Name": "Howl",
				"Target":"Player",
				"Damage": 15, 
				"Type": "Ranged",
				"cost": 2,
			}
		}
	},
	3: {
		"Name": "Lizard",
		"Frame": 0,
		"Health": 10,
		"Level": 10,
		"Exp": 0,
		"MaxExp": 0,
		"Defense": 0,
		"Weakness": "Magic",
		"Scene": preload("res://Monsters/minotaur.tscn"), # placeholder
		"Attacks": {
			0: {
				"Name": "Slash",
				"Target":"Player",
				"Damage": 15, 
				"Type": "Physical",
				"cost": 2,
			},
			1: {
				"Name": "Bite",
				"Target":"Player",
				"Damage": 20, 
				"Type": "Physical",
				"cost": 2,
			},
			2: {
				"Name": "Spit",
				"Target":"Player",
				"Damage": 5, 
				"Type": "Ranged",
				"cost": 2,
			}
		}
	},
	4: {
		"Name": "Knight",
		"Frame": 0,
		"Health": 10,
		"Level": 1,
		"Exp": 0,
		"MaxExp": 0,
		"Defense": 0,
		"Weakness": "Ranged",
		"Scene": preload("res://Monsters/minotaur.tscn"), # placeholder
		"Attacks": {
			0: {
				"Name": "Slash",
				"Target":"Player",
				"Damage": 15, 
				"Type": "Physical",
				"cost": 2,
			},
			1: {
				"Name": "Bow",
				"Target":"Player",
				"Damage": 20, 
				"Type": "Ranged",
				"cost": 2,
			},
			2: {
				"Name": "Throw Rock",
				"Target":"Player",
				"Damage": 5, 
				"Type": "Ranged",
				"cost": 2,
			}
		}
	},
	5: {
		"Name": "Wizard",
		"Frame": 0,
		"Health": 10,
		"Level": 1,
		"Exp": 0,
		"MaxExp": 0,
		"Defense": 0,
		"Weakness": "Physical",
		"Scene": preload("res://Monsters/minotaur.tscn"), # placeholder
		"Attacks": {
			0: {
				"Name": "Fireball",
				"Target":"Player",
				"Damage": 20, 
				"Type": "Physical",
				"cost": 2,
			},
			1: {
				"Name": "Water Slice",
				"Target":"Player",
				"Damage": 10, 
				"Type": "Physical",
				"cost": 2,
			},
			2: {
				"Name": "Thunder Bolt",
				"Target":"Player",
				"Damage": 10, 
				"Type": "Ranged",
				"cost": 2,
			}
		}
	},
	6: {
		"Name": "King Taxalot",
		"Frame": 0,
		"Health": 10,
		"Level": 1,
		"Exp": 0,
		"MaxExp": 0,
		"Defense": 0,
		"Weakness": "Magic",
		"Scene": preload("res://Monsters/minotaur.tscn"), # placeholder
		"Attacks": {
			0: {
				"Name": "Slash",
				"Target":"Player",
				"Damage": 15, 
				"Type": "Physical",
				"cost": 2,
			},
			1: {
				"Name": "Ram",
				"Target":"Player",
				"Damage": 20, 
				"Type": "Physical",
				"cost": 2,
			},
			2: {
				"Name": "Throw Rock",
				"Target":"Player",
				"Damage": 5, 
				"Type": "Ranged",
				"cost": 2,
			}
		}
	},
	
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
				"Damage": 20, 
				"Type": "Physical",
				"cost": 2,
			},
			1: {
				"Name": "Bow",
				"Target":"Monster",
				"Damage": 20, 
				"Type": "Ranged",
				"cost": 2,
			},
			2: {
				"Name": "Magic",
				"Target":"Monster",
				"Damage": 2000, 
				"Type": "Magic",
				"cost": 2,
			}
		}
	}
}

func addEXP(amount):
	selectedMonsters[0]["Exp"] += amount
	while selectedMonsters[0]["Exp"] >= selectedMonsters[0]["MaxExp"]:
		#LEVEL UP
		selectedMonsters[0]["Level"] += 1
		selectedMonsters[0]["Exp"] = int(selectedMonsters[0]["Exp"]) - int(selectedMonsters[0]["MaxExp"])
		selectedMonsters[0]["MaxExp"] = int(calculate_exp_to_next_level(selectedMonsters[0]["Level"] - 1))
	
#Atk / (Def+100 / 100)
func calculate_damage(defense: int, attack_power: int, level: int, weak: bool) -> int:
	# Apply defense mitigation, so higher defense reduces incoming damage
	var damage = max(attack_power * (1-(defense * 0.01)), 1)  # Ensure at least 1 damage
	if weak:
		damage *= 1.5
	
	# Round damage to an integer for final output
	return int(damage)

func calculate_attack_power(base_attack_power: int, level: int) -> int: # works
	var scaled_attack_power = base_attack_power * (1 + level / 20.0)
	return int(scaled_attack_power + randi_range(0, level / 2))

func calculate_defense(level: int) -> int: # works
	# Calculate defense using a quadratic formula, capped at 50 and starting from 0 at level 1
	var defense = int(pow((level), 2) * 0.05)  # Quadratic growth starting from level 1
	return min(defense, 50)  # Cap defense at 50

# Function to calculate EXP gained from a monster at a given level
func calculate_exp_per_monster(monster_level: int) -> float:
	# This calculates how much EXP you gain from defeating a monster of level 'monster_level'
	return base_exp * pow(monster_level, growth_factor)

# Function to calculate the EXP threshold to level up to the next level
func calculate_exp_to_next_level(level: int) -> float:
	# Get the EXP gained from the monster at the previous level (level - 1)
	var exp_from_previous_level = calculate_exp_per_monster(level - 1)
	# Multiply it by 1.5 to get the required EXP to level up to the next level
	return exp_from_previous_level * level_multiplier
