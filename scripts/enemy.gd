extends CharacterBody2D
var hp=100
func take_damage(d):hp-=d;if hp<=0:queue_free()
