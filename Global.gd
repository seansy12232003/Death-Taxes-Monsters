extends Node

var documents = 0
# Called when the node enters the scene tree for the first time.
var gold = 50
var items = {
	0: {
		"Name" : "Magic",
		"Description" : "Woo Waa Magic",
		"Cost" : 25,
		"Icon" : preload("res://staff.jpg")
	},
	1:{
		"Name" : "Sword",
		"Description" : "Slash",
		"Cost" : 25,
		"Icon" : preload("res://sword.png")
	},
	2:{
		"Name" : "Bow",
		"Description" : "pew pew",
		"Cost" : 25,
		"Icon" : preload("res://bow.jpg")
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
