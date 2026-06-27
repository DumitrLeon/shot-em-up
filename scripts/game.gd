extends Node2D

@export var spawn_rate = 2.0
var themes: Dictionary = {}

func _ready() -> void:
	var enemies_open = DirAccess.open("res://scenes/enemies/")
	for theme_folder in enemies_open.get_directories():
		
		themes[theme_folder] = {
			"environment" : [],
			"hostile" : [],
			"traps" : []
			}
		
		var theme_path = "res://scenes/enemies/"+theme_folder
		
		var theme_open = DirAccess.open(theme_path)
		for category in theme_open.get_directories():
			
			var category_path = theme_path +"/"+ category
			var category_open = DirAccess.open(category_path)
			for file in category_open.get_files():
				
				if file.ends_with(".tscn"):
					var file_scene = load(category_path+"/"+file)
					
					match category:
						"environment":
							themes[theme_folder]["environment"].append(file_scene)
						"hostile":
							themes[theme_folder]["hostile"].append(file_scene)
						"traps":
							themes[theme_folder]["traps"].append(file_scene)
					#qua modificherò per la memorizzazzione di tutte cose
	

var timer = 0.0
var timer_2 = 0.0
func _process(delta: float) -> void:
	if timer_2 >= 1:
		timer_2 = 0.0
		$UI_manager/seconds.text = str(int($UI_manager/seconds.text) + 1)
	else:
		timer_2 += delta
	
	if timer >= spawn_rate:
		timer = 0.0
		var spawn_x = 400
		var spawn_y = randi_range(-104, 112)
		
		var enemy_scene = preload("res://scenes/enemies/theme_1/hostile/space_scout.tscn")
		var enemy = enemy_scene.instantiate()
		enemy.global_position = Vector2(spawn_x, spawn_y)
		$Enemies.add_child(enemy)
		
	else:
		timer += delta
		
