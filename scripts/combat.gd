extends Node
var critical_chance = 0.1

func calculate_damage(attacker, defender):
    var damage = attacker.attack_power
    if randf() < critical_chance:
        damage *= 2
    return int(damage)
