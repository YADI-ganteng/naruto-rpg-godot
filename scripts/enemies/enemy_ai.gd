extends Node

var enemy_scene = preload("res://scenes/enemies/Enemy.tscn")

func spawn_enemy(enemy_type, position):
    var enemy = enemy_scene.instantiate()
    enemy.enemy_type = enemy_type
    enemy.position = position
    return enemy

func spawn_wave(wave_number, parent_node):
    var enemies_data = load_enemies_data()
    var count = 2 + wave_number * 2
    var spawned = []
    
    for i in range(count):
        var type = "bandit"
        if wave_number > 3: type = "ninja_liar"
        if wave_number > 5: type = "ronin"
        if wave_number > 8: type = "akatsuki_member"
        
        var enemy = spawn_enemy(type, Vector2(randi() % 700 + 50, randi() % 350 + 50))
        parent_node.add_child(enemy)
        spawned.append(enemy)
    
    return spawned

func load_enemies_data():
    var file = FileAccess.open("res://data/enemies.json", FileAccess.READ)
    return JSON.parse_string(file.get_as_text())
