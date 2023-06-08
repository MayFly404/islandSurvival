extends Node2D

# Notes #
# 1 - Water
# 2 - land

var width = 30
var height = 30

func get_level_row():
	var row = []
	for i in range(width):
		row.append("1")
	return row

var level = []

func _ready():
	for i in range(height):
		level.append(get_level_row())
	for row in level:
		print(''.join(row) )
		
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
