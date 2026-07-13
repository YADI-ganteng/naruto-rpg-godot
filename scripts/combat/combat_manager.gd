extends Node

var is_battle = false
var current_enemies = []
var turn_order = []
var current_turn_index = 0

func start_battle(player, enemies):
    is_battle = true
    current_enemies = enemies
    turn_order = [player] + enemies
    current_turn_index = 0
    print("Battle started!")

func next_turn():
    current_turn_index += 1
    if current_turn_index >= turn_order.size():
        current_turn_index = 0

func get_current_actor():
    return turn_order[current_turn_index]

func end_battle():
    is_battle = false
    current_enemies = []
    turn_order = []
    print("Battle ended!")

func calculate_damage(attacker, defender, skill = null):
    var damage = attacker.attack_power
    if skill:
        damage = skill.damage
    var crit = randf() < 0.1
    if crit:
        damage *= 2
    return int(damage)
