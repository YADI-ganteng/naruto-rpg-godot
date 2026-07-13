extends Node2D
var current_wave = 1
var enemies_alive = 0

func _ready():
    spawn_wave()

func spawn_wave():
    var count = 3 + current_wave
    enemies_alive = count
    print("Wave ", current_wave, " started with ", count, " enemies!")

func _on_enemy_defeated():
    enemies_alive -= 1
    if enemies_alive <= 0:
        current_wave += 1
        spawn_wave()
