extends Node2D

const TILE = preload("res://tile.tscn")
var distance = Vector2(256, 128)
var offset = Vector2(0, 0)
var size = 1

var grasses = ["res://Assets/Isometric/grass_E.png", "res://Assets/Isometric/grass_N.png", "res://Assets/Isometric/grass_S.png", "res://Assets/Isometric/grass_W.png"]
var hills_high = ["res://Assets/Isometric/grassHillHigh_E.png", "res://Assets/Isometric/grassHillHigh_N.png", "res://Assets/Isometric/grassHillHigh_S.png", "res://Assets/Isometric/grassHillHigh_W.png"]
var hills = ["res://Assets/Isometric/grassHill_E.png", "res://Assets/Isometric/grassHill_N.png", "res://Assets/Isometric/grassHill_S.png", "res://Assets/Isometric/grassHill_W.png"]
var stones_large = ["res://Assets/Isometric/grassStoneLarge_E.png", "res://Assets/Isometric/grassStoneLarge_N.png", "res://Assets/Isometric/grassStoneLarge_S.png", "res://Assets/Isometric/grassStoneLarge_W.png"]
var stones_small = ["res://Assets/Isometric/grassStoneSmall_E.png", "res://Assets/Isometric/grassStoneSmall_N.png", "res://Assets/Isometric/grassStoneSmall_S.png", "res://Assets/Isometric/grassStoneSmall_W.png"]
var stumps = ["res://Assets/Isometric/grassTreeStump_E.png", "res://Assets/Isometric/grassTreeStump_N.png", "res://Assets/Isometric/grassTreeStump_S.png", "res://Assets/Isometric/grassTreeStump_W.png"]
var stumps_axe = ["res://Assets/Isometric/grassTreeStumpAxe_E.png", "res://Assets/Isometric/grassTreeStumpAxe_N.png", "res://Assets/Isometric/grassTreeStumpAxe_S.png", "res://Assets/Isometric/grassTreeStumpAxe_W.png"]
var dead_trees_large = ["res://Assets/Isometric/treeDeadLarge_E.png", "res://Assets/Isometric/treeDeadLarge_N.png", "res://Assets/Isometric/treeDeadLarge_S.png", "res://Assets/Isometric/treeDeadLarge_W.png"]
var dead_trees_small = ["res://Assets/Isometric/treeDeadSmall_E.png", "res://Assets/Isometric/treeDeadSmall_N.png", "res://Assets/Isometric/treeDeadSmall_S.png", "res://Assets/Isometric/treeDeadSmall_W.png"]
var tree_pine_huge = ["res://Assets/Isometric/treePineHuge_E.png", "res://Assets/Isometric/treePineHuge_N.png", "res://Assets/Isometric/treePineHuge_S.png", "res://Assets/Isometric/treePineHuge_W.png"]
var tree_pine_large = ["res://Assets/Isometric/treePineLarge_E.png", "res://Assets/Isometric/treePineLarge_N.png", "res://Assets/Isometric/treePineLarge_S.png", "res://Assets/Isometric/treePineLarge_W.png"]
var tree_pine_small = ["res://Assets/Isometric/treePineSmall_E.png", "res://Assets/Isometric/treePineSmall_N.png", "res://Assets/Isometric/treePineSmall_S.png", "res://Assets/Isometric/treePineSmall_W.png"]
var roads = ["res://Assets/Isometric/grassPathStraight_E.png", "res://Assets/Isometric/grassPathStraight_N.png", "res://Assets/Isometric/grassPathStraight_S.png", "res://Assets/Isometric/grassPathStraight_W.png"]

# Called when the node enters the scene tree for the first time.
func _ready():
	var g = TILE.instantiate()
	distance *= g.scale
	
	for i in range(25):
		create_chunk(Vector2(size, size), offset)
		size += 1
		#await get_tree().create_timer(0.1).timeout
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

func create_chunk(size: Vector2, position: Vector2):
	var global_position = Vector2()
	var most_recent_i
	var most_recent_j
	for i in range(position.x, position.x + size.x):
		#await get_tree().create_timer(0.01).timeout
		for j in range(position.y, position.y + size.y):
			#await get_tree().create_timer(0.01).timeout
			global_position.x = (j - i) * distance.x
			global_position.y = (j + i) * distance.y

			if i == position.x + size.x - 1 or j == position.y + size.y - 1:
				add_tile(grasses.pick_random(), global_position)

				var rand = randf() * 15
				if rand < 1: # Plant a tree
					add_tile([tree_pine_small, tree_pine_large, tree_pine_huge, stumps, stumps_axe].pick_random().pick_random(), global_position)
				elif rand < 2: # Plant a dead tree
					add_tile([dead_trees_small, dead_trees_large].pick_random().pick_random(), global_position)
				elif rand < 3: # Place stones
					add_tile([stones_small, stones_large].pick_random().pick_random(), global_position)
				elif rand < 4: # Grow hills
					add_tile([hills, hills_high].pick_random().pick_random(), global_position)

func add_tile(resource, position):
	var g = TILE.instantiate()
	g.set_tile(resource)
	g.global_position = position * g.scale
	add_child(g)
