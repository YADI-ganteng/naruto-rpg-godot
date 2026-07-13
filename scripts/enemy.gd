extends CharacterBody2D
var hp=100
var speed=200
func _physics_process(d):move_and_slide()
func take_damage(d):hp-=d;if hp<=0:queue_free()
