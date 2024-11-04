extends Node


# Called when the node enters the scene tree for the first time.
var gold = 3000
var items = {
	0: {
		"Name" : "Magic",
		"Description" : "Woo Waa Magic",
		"Cost" : 10,
		"Icon" : preload("res://staff.jpg")
	},
	1:{
		"Name" : "Sword",
		"Description" : "Slash",
		"Cost" : 15,
		"Icon" : preload("res://sword.png")
	},
	2:{
		"Name" : "Bow",
		"Description" : "pew pew",
		"Cost" : 10,
		"Icon" : preload("res://bow.jpg")
	},
	3:{
		"Name" : "Health Potion",
		"Description" : "Heals you for 50 health points",
		"Cost" : 500,
		"Icon" : preload("res://Potion+small (1).png")
	},
}
var inventory = {
	0: {
		"Name" : "Sword",
		"Description" : "Slash",
		"Cost" : 15,
		"Icon" : preload("res://sword.png"),
		"Count" : 1
	},	

}
