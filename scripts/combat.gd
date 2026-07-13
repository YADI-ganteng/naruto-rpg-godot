extends Node
func calculate_damage(a,d):return int(a.attack_power*(1.5 if randf()<0.1 else 1))
