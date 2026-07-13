extends CharacterBody2D
var hp = 100
var speed = 200
var damage = 10
var player = null

func _physics_process(delta):
    if player:
        var direction = (player.position - position).normalized()
        velocity = direction * speed
        move_and_slide()

func take_damage(damage):
    hp -= damage
    if hp <= 0:
        queue_free()
