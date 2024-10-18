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
}
var inventory = {
	0: {
		"Name" : "Magic",
		"Description" : "Woo Waa Magic",
		"Cost" : 10,
		"Count" : 1
	},

}
