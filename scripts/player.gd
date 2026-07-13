extends CharacterBody2D
var speed=400
var hp=500
var cp=200
func _physics_process(d):move_and_slide()
func attack():pass
func take_damage(d):hp-=d
