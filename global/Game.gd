extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	addMonster("Minotaur")


var dataBaseMonsters = {
	0: {
		"Name": "Player",
		"Frame": 0,
		"Health": 100,
		"Level": 1,
		"Exp": 0,
		"MaxExp": 10,
		"Strength": 10,
		"Defense": 5,
		"Scene": preload("res://Player/player.tscn"), # placeholder
		"Attacks": {
			0: {
				"Name": "Slash",
				"Target":"Monster",
				"Damage": 10, 
				"Type": "Physical",
				"cost": 2,
			},
			1: {
				"Name": "Stab",
				"Target":"Monster",
				"Damage": 10, 
				"Type": "Stab",
				"cost": 2,
			},
			2: {
				"Name": "Spell",
				"Target":"Monster",
				"Damage": 10, 
				"Type": "Magic",
				"cost": 2,
			}
		}
	},
	1: {
		"Name": "Minotaur",
		"Frame": 0,
		"Health": 10,
		"Level": 1,
		"Exp": 0,
		"MaxExp": 0,
		"Strength": 10,
		"Defense": 5,
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
				"Name": "Ram",
				"Target":"Player",
				"Damage": 15, 
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
		"Name": "",
		"Frame": 0,
		"Health": 100,
		"Level": 1,
		"Exp": 0,
		"MaxExp": 0,
		"Strength": 10,
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
		"Strength": 10,
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
		"Strength": 10,
		"Defense": 5,
		"Scene": preload("res://Player/player.tscn"), # placeholder
		"Attacks": {
			0: {
				"Name": "Slash",
				"Target":"Monster",
				"Damage": 10, 
				"Type": "Physical",
				"cost": 2,
			},
			1: {
				"Name": "Throw Rock",
				"Target":"Monster",
				"Damage": 10, 
				"Type": "Ranged",
				"cost": 2,
			},
			2: {
				"Name": "Spell",
				"Target":"Monster",
				"Damage": 10, 
				"Type": "Magic",
				"cost": 2,
			}
		}
	}
}

func addMonster(Name):
	for i in dataBaseMonsters:
		if dataBaseMonsters[i]["Name"] == Name:
			var tempDic = dataBaseMonsters[i].duplicate(true)
			selectedMonsters[selectedMonsters.size()] = tempDic
			
			

func addEXP(amount):
	if selectedMonsters[0]["Exp"] >= selectedMonsters[0]["MaxExp"]:
		#LEVEL UP
		selectedMonsters[0]["Level"] += 1
		selectedMonsters[0]["Exp"] = int(selectedMonsters[0]["Exp"]) % int(selectedMonsters[0]["MaxExp"])
		selectedMonsters[0]["MaxExp"] = selectedMonsters[0]["MaxExp"] * 1.25
	
